//
//  PokeView.swift
//  PokeAPI
//
//  Created by Diggo Silva on 07/11/23.
//

import UIKit

class PokeView: UIView {
    
    // MARK: - Properties
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = UIColor.orangePokeAPI
        indicator.style = .large
        indicator.startAnimating()
        return indicator
    }()
    
    lazy var currentUserLogButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = .systemFont(ofSize: 12)
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PokeCell.self, forCellReuseIdentifier: PokeCell.identifier)
        return tableView
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        backgroundColor = .systemBackground
        addSubview(currentUserLogButton)
        addSubview(tableView)
        addSubview(activityIndicator)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            currentUserLogButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            currentUserLogButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            currentUserLogButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            currentUserLogButton.heightAnchor.constraint(equalToConstant: 20),
            
            tableView.topAnchor.constraint(equalTo: currentUserLogButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
