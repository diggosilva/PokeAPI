//
//  ViewController.swift
//  PokeAPI
//
//  Created by Diggo Silva on 07/11/23.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    private let pokeView = PokeView()
    private let service = Service.shared
    private var pokemons: [Results] = []
    
    let dispatchGroup = DispatchGroup()
    
    override func loadView() {
        super.loadView()
        view = pokeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        setupTableViewDelegatesAndDataSources()
        fetchData()
    }
    
    private func configNavigationBar() {
        title = "PokeAPI"
    }
    
    private func setupTableViewDelegatesAndDataSources() {
        pokeView.tableView.delegate = self
        pokeView.tableView.dataSource = self
    }
    
    private func fetchData() {
        service.getPokeName { results in
            DispatchQueue.main.async {
                self.pokemons = results
                self.pokeView.tableView.reloadData()
                print(results)
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokeCell.identifier, for: indexPath) as? PokeCell else { return UITableViewCell() }
        cell.configure(model: pokemons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
