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
    private let dispatchGroup = DispatchGroup()
    private var pokemons: [PokemonModel] = []
    
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
//        dispatchGroup.enter()
//        service.getPokeName { results in
//            for result in results {
//                self.dispatchGroup.enter()
//                self.service.getPokeImage(name: result.name) { image in
//                    self.pokemons.append(PokemonModel(image: image, name: result.name))
//                    self.dispatchGroup.leave()
//                }
//            }
//            self.dispatchGroup.leave()
//        }
//        dispatchGroup.notify(queue: .main) {
//            self.pokeView.tableView.reloadData()
//            self.pokeView.activityIndicator.stopAnimating()
//        }
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
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
