//
//  SceneAssembler.swift
//  dz_08
//
//  Created by Dmitriy Dudyrev on 16.04.2025.
//

import UIKit

class SceneAssembler {
    func makeScene() -> UIViewController {
        let networkClient = NetworkClient()
        let presenter = Presenter(networkClient: networkClient)
        let view = ViewController(presenter: presenter)
        presenter.view = view
        
        return view
    }
}
