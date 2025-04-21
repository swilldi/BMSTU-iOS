//
//  ViewController.swift
//  dz_09
//
//  Created by Dmitriy Dudyrev on 18.04.2025.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    private lazy var presenter: PresenterInput = Presenter(view: self)
    private var downloadingIndicator: UIActivityIndicatorView?
    
    var imagesStack = UIStackView()
    var downloadButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupIndicator()
        setupButton()
        setupImagesStack()
        
    }
    
    private func setupIndicator() {
        let indicator = UIActivityIndicatorView(style: .large)
        view.addSubview(indicator)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        downloadingIndicator = indicator
    }
    
    private func setupButton() {
        let button = UIButton()
        button.setTitle("Загрузить изображения", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(startDownloadingImages), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        downloadButton = button
    }
    
    @objc func startDownloadingImages() {
        print("Загрузка началась")
        downloadingIndicator?.startAnimating()
        presenter.downoadImages()
    }
    
    private func setupImagesStack() {
        let images = UIStackView()
        images.distribution = .fillEqually
        images.axis = .vertical
        images.spacing = 10
        
        view.addSubview(images)
        images.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            images.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            images.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            images.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            images.bottomAnchor.constraint(equalTo: downloadButton!.topAnchor, constant: -50)
        ])
        
        imagesStack = images
        
        
    }
}


extension ViewController: ViewControllerInput {
    func stopDownloadingIndicator() {
        downloadingIndicator?.stopAnimating()
    }
    
    func updateImages(from imagesData: [Data]) {
        
        imagesStack.arrangedSubviews.forEach {
            imagesStack.removeArrangedSubview($0)
                $0.removeFromSuperview()
            }
        
        for i in 0..<imagesData.count {
            let data = imagesData[i]
            let image = UIImage(data: data)
            let imageView = UIImageView(image: image)
            
            imageView.contentMode = .scaleAspectFit
            
            imagesStack.addArrangedSubview(imageView)
        }
        
    }
}
