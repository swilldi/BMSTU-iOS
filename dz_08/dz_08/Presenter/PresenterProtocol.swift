//
//  PresenterProtocol.swift
//  dz_08
//
//  Created by Dmitriy Dudyrev on 16.04.2025.
//

import Foundation

protocol PresenterProtocol: AnyObject {
    var itemCount: Int { get }
    
    func viewDidLoad()
    subscript(_ index: Int) -> Item { get }
    func didTapDownloadButton()
}
