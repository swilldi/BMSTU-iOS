//
//  ViewController.swift
//  dz_07
//
//  Created by Dmitriy Dudyrev on 04.04.2025.
//

import UIKit

class ViewController: UIViewController {
    private var itemImage: UIImageView?
    private var companyLabel: UILabel?
    private var titleLabel: UILabel?
    private var priseLabel: UILabel?
    private var nextItemButton: UIButton?
    
    private var item: any Item = Ship.raven
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupShipImage()
        setupButton()
        setupFactory()
        setupShipTitile()
        setupShipPrise()
        setupConstrains()
    }
    
    private func setupShipImage() {
        let image = UIImage(named: item.title)
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        view.addSubview(imageView)
        
        itemImage = imageView
    }
    
    private func setupFactory() {
        let factory = UILabel()
        factory.font = .systemFont(ofSize: 30)
        factory.textColor = .gray
        factory.textAlignment = .center
        factory.numberOfLines = 1
        factory.text = item.company
        view.addSubview(factory)
        
        companyLabel = factory
    }
    
    private func setupShipTitile() {
        let title = UILabel()
        title.font = .systemFont(ofSize: 40)
        title.textColor = .white
        title.textAlignment = .center
        title.numberOfLines = 1
        title.text = item.title.capitalized
        view.addSubview(title)
        
        titleLabel = title
    }
    
    private func setupShipPrise() {
        let prise = UILabel()
        prise.font = .systemFont(ofSize: 30)
        prise.textColor = .white
        prise.textAlignment = .center
        prise.numberOfLines = 1
        prise.text = item.prise
        view.addSubview(prise)
        
        priseLabel = prise
    }
    
    private func setupButton() {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.backgroundColor = .white
        
        button.setTitle("Слудующий корабль", for: .normal)
        button.setTitleColor(.black, for: .normal)
        
        button.layer.cornerRadius = 12
        
        
        view.addSubview(button)
        
        nextItemButton = button
    }
    
    @objc private func didTapButton() {
        // Вот тут вопрос для чего тут требуется вставка "as! any Item"
        item = item.next() as! any Item
        
        itemImage?.image = UIImage(named: item.title)
        companyLabel?.text = item.company
        titleLabel?.text = item.title.capitalized
        priseLabel?.text = item.prise
    }
    
    
    private func setupConstrains() {
        guard let itemImage, let companyLabel, let titleLabel, let priseLabel, let nextItemButton else { return }
    
        
        itemImage.translatesAutoresizingMaskIntoConstraints = false
        companyLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priseLabel.translatesAutoresizingMaskIntoConstraints = false
        nextItemButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // место для shipImage
            
            itemImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            itemImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            itemImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            itemImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            
            companyLabel.topAnchor.constraint(equalTo: itemImage.bottomAnchor, constant: 10),
            companyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            
            titleLabel.topAnchor.constraint(equalTo: companyLabel.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            priseLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            priseLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            
            nextItemButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            nextItemButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextItemButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.43),
            nextItemButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.08)
            
        ])
    }
}
