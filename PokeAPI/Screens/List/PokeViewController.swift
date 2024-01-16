//
//  ViewController.swift
//  PokeAPI
//
//  Created by Diggo Silva on 07/11/23.
//

import UIKit
import SDWebImage
import FirebaseAuth

class PokeViewController: UIViewController {
    
    private let pokeView = PokeView()
    private let service = Service.shared
    private let dispatchGroup = DispatchGroup()
    private var pokemons: [PokemonModel] = []
    private var filteredPokemons: [PokemonModel] = []
    
    //MARK: - Lifecyle
    
    override func loadView() {
        super.loadView()
        view = pokeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        fetchData()
        setupDelegatesAndDataSources()
        getCurrentUserEmail()
    }
    
    //MARK: - Methods
    
    private func getCurrentUserEmail() {
        if let user = Auth.auth().currentUser {
            guard let userEmail = user.email else { return }
            let button = Components.buildButtonWith2Texts(button: pokeView.currentUserLogButton, firstString: "Logado com o email: ", firstStringFont: UIFont.systemFont(ofSize: 12), firstStringColor: UIColor.label, secondString: userEmail, secondStringFont: UIFont.systemFont(ofSize: 12, weight: .bold), secondStringColor: UIColor.systemGreen)
        }
    }
    
    private func configNavigationBar() {
        let imageView = UIImageView(image: UIImage(named: "logo"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", image: nil, target: self, action: #selector(didTapLogoutButton))
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    //MARK: - Actions
    
    @objc func didTapLogoutButton() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Erro ao deslogar: %@", signOutError)
        }
    }
    
    //MARK: - Setup TableView
    
    private func setupDelegatesAndDataSources() {
        pokeView.tableView.delegate = self
        pokeView.tableView.dataSource = self
        pokeView.searchBar.delegate = self
    }
    
    //MARK: - API Call
    
    private func fetchData() {
        dispatchGroup.enter()
        service.getPokeName { results in
            for result in results {
                self.dispatchGroup.enter()
                self.service.getPokeImage(name: result.name) { pokemon in
                    self.pokemons.append(PokemonModel(
                        height: pokemon.height,
                        weight: pokemon.weight,
                        experience: pokemon.baseExperience,
                        id: pokemon.id,
                        image: pokemon.sprites.other.officialArtwork.frontDefault,
                        name: result.name)
                    )
                    self.dispatchGroup.leave()
                }
            }
            self.dispatchGroup.leave()
        }
        dispatchGroup.notify(queue: .main) {
            self.pokeView.tableView.reloadData()
            self.pokeView.activityIndicator.stopAnimating()
        }
    }
}

//MARK: - UITableViewDelegate UITableViewDataSource

extension PokeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemons.count == 0 ? pokemons.count : filteredPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PokeCell.identifier, for: indexPath) as? PokeCell else { return UITableViewCell() }
        if filteredPokemons.count == 0 {
            cell.configure(model: pokemons[indexPath.row])
        } else {
            cell.configure(model: filteredPokemons[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = PokeDetailsViewController()
        if filteredPokemons.count == 0 {
            let pokeSelected = pokemons[indexPath.row]
            guard let url = URL(string: pokeSelected.image) else { return }
            DispatchQueue.main.async {
                vc.imageView.sd_setImage(with: url)
                vc.heightLabel.text = "Altura: \(pokeSelected.height)cm"
                vc.weightLabel.text = "Peso: \(pokeSelected.weight)g"
                vc.experienceLabel.text = "XP: \(pokeSelected.experience)"
                vc.idLabel.text = "ID: \(pokeSelected.id)"
                vc.nameLabel.text = "\(pokeSelected.name)".capitalized
            }
        } else {
            let pokeSelected = filteredPokemons[indexPath.row]
            guard let url = URL(string: pokeSelected.image) else { return }
            DispatchQueue.main.async {
                vc.imageView.sd_setImage(with: url)
                vc.heightLabel.text = "Altura: \(pokeSelected.height)cm"
                vc.weightLabel.text = "Peso: \(pokeSelected.weight)g"
                vc.experienceLabel.text = "XP: \(pokeSelected.experience)"
                vc.idLabel.text = "ID: \(pokeSelected.id)"
                vc.nameLabel.text = "\(pokeSelected.name)".capitalized
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension PokeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPokemons = searchText.isEmpty ? pokemons : pokemons.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        pokeView.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        filteredPokemons = pokemons
        pokeView.tableView.reloadData()
    }
}
