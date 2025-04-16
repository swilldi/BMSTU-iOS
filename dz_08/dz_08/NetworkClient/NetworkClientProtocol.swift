//
//  NetworkClient.swift
//  dz_08
//
//  Created by Dmitriy Dudyrev on 16.04.2025.
//

import Foundation

protocol NetworkClientProtocol: AnyObject {
    func get<T: Decodable>(
        urlString: String,
        completion: @escaping (Result<T, NetworkClientError>) -> Void
    )
    
    func download(
        url: String,
        progressBlock: ((Double) -> Void)?,
        completion: @escaping (Result<Data, NetworkClientError>) -> Void
    )
}
