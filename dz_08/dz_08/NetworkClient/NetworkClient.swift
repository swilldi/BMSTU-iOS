//
//  NetworkClient.swift
//  dz_08
//
//  Created by Dmitriy Dudyrev on 16.04.2025.
//

import Foundation

class NetworkClient: NSObject {
    private var progressBlocks = [Int:(Double) -> Void]()
    private var competionBlocks = [Int:(Result<Data, NetworkClientError>) -> Void]()
    
    private lazy var urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
}

extension NetworkClient: NetworkClientProtocol {
    func download(url: String, progressBlock: ((Double) -> Void)?, completion: @escaping (Result<Data, NetworkClientError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = urlSession.downloadTask(with: request)
        progressBlocks[task.taskIdentifier] = progressBlock
        competionBlocks[task.taskIdentifier] = completion
    }
    
    func get<T: Decodable>(urlString: String, completion: @escaping (Result<T, NetworkClientError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            } else if let error = error {
                completion(.failure(.networkError(error)))
            }
        }
        task.resume()
    }
}

extension NetworkClient: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let completion = competionBlocks[downloadTask.taskIdentifier],
           let data = try? Data(contentsOf: location) {
            completion(.success(data))
        }
        competionBlocks.removeValue(forKey: downloadTask.taskIdentifier)
        progressBlocks.removeValue(forKey: downloadTask.taskIdentifier)
    }
    
    func urlSession(
        _ session: URLSession,
        downloadTask: URLSessionDownloadTask,
        didWriteData bytesWritten: Int64,
        totalBytesWritten: Int64,
        totalBytesExpectedToWrite: Int64
    ) {
        if totalBytesWritten > 0 {
            let progress = Double(totalBytesWritten) / Double(totalBytesExpectedToWrite)
            progressBlocks[downloadTask.taskIdentifier]?(progress)
        }
    }
}
