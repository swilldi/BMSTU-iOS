//
//  ViewController.swift
//  dz_11
//
//  Created by Dmitriy Dudyrev on 30.04.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var logoImage: UIImageView?
    var button: UIButton?
    var label: UILabel?
    
    var logoImageTop: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimate()
    }
    
    private func setupUI() {
        setupImage()
        setupLabel()
        setupButton()
        
        guard
            let logoImage,
            let button,
            let label
        else {
            return
        }
        
        self.logoImageTop = logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -logoImage.frame.height)
    
        NSLayoutConstraint.activate([
            logoImageTop!,
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            logoImage.heightAnchor.constraint(equalTo: view.widthAnchor),
    
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -50),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 0.25),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 150),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
            button.transform = CGAffineTransform(translationX: 0, y: 400).scaledBy(x: 0.1, y: 0.1).rotated(by: -.pi)
    }
    
    private func setupImage() {
        let image = UIImage(named: "Minecraft_Launcher.png")
        let imageView = UIImageView(image: image)
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImage = imageView
        view.addSubview(imageView)
        
    }
    
    private func setupLabel() {
        let label = UILabel()
        label.text = "Это просто текст"
        label.font = .systemFont(ofSize: 30)
        label.alpha = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        self.label = label
        view.addSubview(label)
        
    }
    
    private func setupButton() {
        let button = UIButton()
        button.setTitle("Нажми", for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        self.button = button
    }
    
    private func startAnimate() {
        guard
            let logoImageTop
        else {
            return
        }
        
        // MARK: Картинка спускается
        let timeToImage = 1.5
        logoImageTop.constant = 150
        UIView.animate(withDuration: timeToImage) {
            self.view.backgroundColor = .systemGreen
            self.view.layoutIfNeeded()
        }
        
        // MARK: Проявление текста
        let timeToLabel = 1.0
        UIView.animate(withDuration: timeToLabel, delay: timeToImage) {
            self.label?.alpha = 1
        }
        
//        // MARK: Кнопка вылитает
        let timeToButton = 1.0
        UIView.animate(withDuration: timeToButton, delay: timeToImage) {
            self.button?.transform = .identity
        }
    }
}

