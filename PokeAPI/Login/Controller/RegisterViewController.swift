//
//  RegisterViewController.swift
//  PokeAPI
//
//  Created by Diggo Silva on 08/11/23.
//

import UIKit
import FirebaseAuth 

class RegisterViewController: UIViewController {
    
    private let registerView = RegisterView()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        registerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        self.registerView.emailTextfield.text = ""
        self.registerView.passwordTextfield.text = ""
        self.registerView.emailTextfield.becomeFirstResponder()
    }
    
    // MARK: - Methods Helpers
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel) { action in
            self.registerView.emailTextfield.text = ""
            self.registerView.passwordTextfield.text = ""
            self.registerView.resignFirstResponder()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
}

// MARK: - RegisterViewDelegate

extension RegisterViewController: RegisterViewDelegate {
    func didTapRegisterButton() {
        
        guard let email = registerView.emailTextfield.text, let password = registerView.passwordTextfield.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                self.showAlert(title: "🛑 Falha!", message: "\(error?.localizedDescription ?? "")")
            } else {
                let vc = PokeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
                self.showAlert(title: "🟢 Sucesso", message: "Seja bem-vindo!")
            }
        }
    }
    
    func didTapGoToLoginButton() {
        let vc = LoginViewController()
        navigationController?.popToRootViewController(animated: true)
        registerView.emailTextfield.text = ""
        registerView.passwordTextfield.text = ""
    }
}
