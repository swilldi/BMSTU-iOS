//
//  NetworkClienError.swift
//  dz_08
//
//  Created by Dmitriy Dudyrev on 16.04.2025.
//

import Foundation

enum NetworkClientError: Error {
    case invalidURL
    case encodingError(Error)
    case networkError(Error)
    case httpError(Int)
    case decodingError(Error)
}
