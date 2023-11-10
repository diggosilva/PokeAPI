//
//  LoginViewController.swift
//  PokeAPI
//
//  Created by Diggo Silva on 08/11/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        loginView.delegate = self
        checkIfLogged()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        self.loginView.emailTextfield.text = ""
        self.loginView.passwordTextfield.text = ""
        self.loginView.emailTextfield.becomeFirstResponder()
    }
    
    // MARK: - Method Check If Logged
    
    func checkIfLogged() {
        if Auth.auth().currentUser == nil {
            showLoginScreen()
        } else {
            showMainScreen()
        }
    }
    
    // MARK: - Method Helpers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel) { action in
            self.loginView.emailTextfield.text = ""
            self.loginView.passwordTextfield.text = ""
            self.loginView.resignFirstResponder()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

// MARK: - LoginViewDelegate

extension LoginViewController: LoginViewDelegate {
    func showLoginScreen() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    func showMainScreen() {
        let vc = PokeViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapButtonLogin() {
        guard let email = loginView.emailTextfield.text, let password = loginView.passwordTextfield.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { usuario, error in
            
            if error != nil {
                self.showAlert(title: "🛑 Falha!", message: "Dados incorretos, ou você não tem uma conta cadastrada! Tente novamente")
            } else {
                if usuario == nil {
                    self.showAlert(title: "🛑 Falha!", message: "Erro inesperado.")
                } else {
                    let vc = PokeViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    func didTapGoToRegisterButton() {
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
        loginView.emailTextfield.text = ""
        loginView.passwordTextfield.text = ""
    }
}
