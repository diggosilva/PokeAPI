//
//  PokeCell.swift
//  PokeAPI
//
//  Created by Diggo Silva on 07/11/23.
//

import UIKit
import SDWebImage

class PokeCell: UITableViewCell {
    
    static let identifier = "PokeCell"
    
    lazy var pokeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray4
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var pokeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Nome do Pokemon"
        label.font = .monospacedSystemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Results) {
        DispatchQueue.main.async {
            self.pokeImage.image = UIImage(systemName: "person.fill")
            self.pokeLabel.text = model.name.capitalized
        }
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        contentView.addSubview(pokeImage)
        contentView.addSubview(pokeLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            pokeImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            pokeImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            pokeImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            pokeImage.widthAnchor.constraint(equalToConstant: 80),
            pokeImage.heightAnchor.constraint(equalToConstant: 80),
            
            pokeLabel.centerYAnchor.constraint(equalTo: pokeImage.centerYAnchor),
            pokeLabel.leadingAnchor.constraint(equalTo: pokeImage.trailingAnchor, constant: 10),
            pokeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
}
