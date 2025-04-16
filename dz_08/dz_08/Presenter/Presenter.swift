//
//  Presenter.swift
//  dz_08
//
//  Created by Dmitriy Dudyrev on 16.04.2025.
//
import Foundation
class Presenter {
    weak var view: ViewProtocol?
    
    private let networkClient: NetworkClientProtocol
    private var items = [Item]()
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    private func loadItems() {
        let url = "https://fakestoreapi.com/products"
        let completion: ((Result<[Item], NetworkClientError>) -> Void) = { result in
            switch result {
            case .success(let items):
                self.items = items
                DispatchQueue.main.async {
                    self.view?.updateTable()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        networkClient.get(urlString: url, completion: completion)
    }
}

extension Presenter: PresenterProtocol {
    var itemCount: Int {
        items.count
    }
    
    func viewDidLoad() {
        loadItems()
    }
    
    subscript(index: Int) -> Item {
        items[index]
    }
    
    func didTapDownloadButton() {
        let url = "https://fakestoreapi.com/products"
        let completion: (Result<Data, NetworkClientError>) -> Void = { result in
            switch result {
            case .success(let data):
                print(data)
                
            case .failure(let errror):
                print(errror.localizedDescription)
            }
        }
        networkClient.download(
            url: url,
            progressBlock: { fraction in
                print(String(fraction * 100))
            },
            completion: completion
        )
    }
    
}
