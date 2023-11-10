//
//  Factory.swift
//  PokeAPI
//
//  Created by Diggo Silva on 08/11/23.
//

import UIKit

class Factory {
    
    static func buildButtonWith2Texts(button: UIButton, firstString: String, firstStringFont: UIFont, firstStringColor: UIColor, secondString: String, secondStringFont: UIFont, secondStringColor: UIColor) -> UIButton {
        let button = button
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedString = NSMutableAttributedString(string: firstString, attributes: [NSAttributedString.Key.font : firstStringFont, NSAttributedString.Key.foregroundColor : firstStringColor])
        let secondText = NSAttributedString(string: secondString, attributes: [NSAttributedString.Key.font : secondStringFont, NSAttributedString.Key.foregroundColor : secondStringColor])
        attributedString.append(secondText)
        
        button.setAttributedTitle(attributedString, for: .normal)
        return button
    }
    
    static func buildLabel(text: String, font: UIFont = .monospacedSystemFont(ofSize: 18, weight: .regular)) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = font
        return label
    }
    
    static func buildTextField(placeholder: String, keyboardType: UIKeyboardType, isSecureTextEntry: Bool = false) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecureTextEntry
        textField.autocorrectionType = .no
        textField.tintColor = .white
        textField.clearButtonMode = .whileEditing
        textField.textColor = .white
        
        let attibutedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.white])
        textField.attributedPlaceholder = attibutedPlaceholder
        return textField
    }
    
    static func buildSeparator() -> UIView {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.backgroundColor = .white
        return separator
    }
}
