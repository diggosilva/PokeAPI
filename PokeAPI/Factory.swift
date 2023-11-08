//
//  Factory.swift
//  PokeAPI
//
//  Created by Diggo Silva on 08/11/23.
//

import UIKit

class Factory {
    
    static func buildLabel(text: String, font: UIFont = .monospacedSystemFont(ofSize: 18, weight: .regular)) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = font
        return label
    }
}
