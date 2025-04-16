//
//  ViewProtocol.swift
//  dz_08
//
//  Created by Dmitriy Dudyrev on 16.04.2025.
//

import UIKit

protocol ViewProtocol: AnyObject {
    func updateTable()
    func updateImage(_ image: UIImage)
}
