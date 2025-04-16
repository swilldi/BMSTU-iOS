//
//  Item.swift
//  dz_08
//
//  Created by Dmitriy Dudyrev on 16.04.2025.
//

import Foundation

struct Item: Decodable {
    var id: Int
    var title: String
    var price: Float
    var description: String
    var category: String
    var image: String
    var rating: [String:Float]
        
}
