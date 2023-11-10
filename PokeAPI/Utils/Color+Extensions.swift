//
//  Color+Extensions.swift
//  PokeAPI
//
//  Created by Diggo Silva on 08/11/23.
//

import UIKit

extension UIColor {
    static var orangePokeAPI = UIColor(red: 222/255, green: 97/255, blue: 84/255, alpha: 1.0) /* #de6154 */
    static var bluePokeAPI = UIColor(red: 66/255, green: 96/255, blue: 165/255, alpha: 1.0)
    static var yellowPokeAPI = UIColor(red: 245/255, green: 204/255, blue: 61/255, alpha: 1.0)
}

extension UIView {
    func addSubviews(views: [UIView]) {
        views.forEach({ self.addSubview($0)})
    }
}
