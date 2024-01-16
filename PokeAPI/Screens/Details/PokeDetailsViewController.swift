//
//  PokeDetailsViewController.swift
//  PokeAPI
//
//  Created by Diggo Silva on 08/11/23.
//

import UIKit

class PokeDetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var cardView: UIView = {
        let cardView = UIView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.backgroundColor = .systemGray4
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOffset = .init(width: 5, height: 5)
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowColor = UIColor.black.cgColor
        return cardView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.orangePokeAPI.cgColor
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    lazy var heightLabel: UILabel = {
        Components.buildLabel(text: "Altura:")
    }()
    
    lazy var weightLabel: UILabel = {
        Components.buildLabel(text: "Peso:")
    }()
    
    lazy var experienceLabel: UILabel = {
        Components.buildLabel(text: "XP:")
    }()
    
    lazy var idLabel: UILabel = {
        Components.buildLabel(text: "ID:")
    }()
    
    lazy var nameLabel: UILabel = {
        Components.buildLabel(text: "Nome do Pokemon", font: .monospacedSystemFont(ofSize: 20, weight: .bold))
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configNavigationBar()
    }
    
    // MARK: - Methods Helpers
    
    private func configNavigationBar() {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        view.backgroundColor = .systemGray5
        view.addSubview(cardView)
        view.addSubview(nameLabel)
        cardView.addSubview(imageView)
        cardView.addSubview(heightLabel)
        cardView.addSubview(weightLabel)
        cardView.addSubview(experienceLabel)
        cardView.addSubview(idLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.widthAnchor.constraint(equalToConstant: 300),
            cardView.heightAnchor.constraint(equalToConstant: 400),
            
            imageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 250),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            heightLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            heightLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            weightLabel.topAnchor.constraint(equalTo: heightLabel.bottomAnchor, constant: 10),
            weightLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            experienceLabel.centerYAnchor.constraint(equalTo: heightLabel.centerYAnchor),
            experienceLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            idLabel.topAnchor.constraint(equalTo: experienceLabel.bottomAnchor, constant: 10),
            idLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor)
        ])
    }
}
