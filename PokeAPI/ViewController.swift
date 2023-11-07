//
//  ViewController.swift
//  PokeAPI
//
//  Created by Diggo Silva on 07/11/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let service = Service.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        service.getPokeName { names in
            print(names)
        }
    }


}

