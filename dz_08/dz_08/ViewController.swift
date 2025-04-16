//
//  ViewController.swift
//  testURL
//
//  Created by Dmitriy Dudyrev on 15.04.2025.
//

import UIKit

class ViewController: UIViewController {
    private let presenter: PresenterProtocol
    
    var imageView: UIImageView?
    var downloadingPercentLabel: UILabel?
    var downloadButton: UIButton?
    var tableView: UITableView?
    
    init(presenter: PresenterProtocol) {
        self.presenter = presenter
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.viewDidLoad()
    }
    
    private func setupUI() {
        setupImage()
        setupDownloadingPercentLabel()
        setupButton()
        setupTable()
        setupConstraint()
    }
    
    private func setupDownloadingPercentLabel() {
        let label = UILabel()
        label.text = "0%"
        
        view.addSubview(label)
        
        downloadingPercentLabel = label
    }
    
    private func setupTable() {
        let tableView = UITableView()
        tableView.register(UITableView.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
        self.tableView = tableView
    }
    
    private func setupImage() {
        let image = UIImage()
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        
        view.addSubview(imageView)
        
        self.imageView = imageView
    }
    
    private func setupButton() {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        button.backgroundColor = .black
        
        button.setTitle("Download", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 30)
        
        button.layer.cornerRadius = 20

        view.addSubview(button)
        
        downloadButton = button
    }
    
    @objc private func didTapButton() {
        presenter.didTapDownloadButton()
    }
    
    private func setupConstraint() {
        guard
            let imageView,
            let downloadingPercentLabel,
            let downloadButton
        else {
            return
        }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        downloadingPercentLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            downloadingPercentLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            downloadingPercentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            imageView.topAnchor.constraint(equalTo: downloadingPercentLabel.bottomAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: downloadingPercentLabel.centerXAnchor),
            
            downloadButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            downloadButton.heightAnchor.constraint(equalTo: downloadButton.widthAnchor, multiplier: 0.25),
        ])
    }
}

extension ViewController: ViewProtocol {
    func updateTable() {
        tableView?.reloadData()
    }
    
    func updateImage(_ image: UIImage) {
        imageView?.image = image
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.itemCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        let item = presenter[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.secondaryText = item.category
        cell.contentConfiguration = content
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {}

