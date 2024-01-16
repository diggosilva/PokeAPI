//
//  LoginView.swift
//  PokeAPI
//
//  Created by Diggo Silva on 08/11/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore

// MARK: - Protocols

protocol LoginViewDelegate: AnyObject {
    func didTapGoToRegisterButton()
    func didTapButtonLogin()
    func showLoginScreen()
    func showMainScreen()
}

class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    // MARK: - Properties
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var emailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "envelope.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var emailTextfield: UITextField = {
        Components.buildTextField(placeholder: "Email", keyboardType: .emailAddress)
    }()
    
    lazy var emailSeparator: UIView = {
        Components.buildSeparator()
    }()
    
    lazy var passwordImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "lock.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var passwordTextfield: UITextField = {
        Components.buildTextField(placeholder: "Senha", keyboardType: .default, isSecureTextEntry: true)
    }()
    
    lazy var passwordSeparator: UIView = {
        Components.buildSeparator()
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Logar", for: .normal)
        button.titleLabel?.font = .monospacedSystemFont(ofSize: 24, weight: .bold)
        button.layer.cornerRadius = 8
        button.tintColor = .yellowPokeAPI
        button.backgroundColor = .bluePokeAPI
        button.addTarget(self, action: #selector(didTapButtonLogin), for: .touchUpInside)
        return button
    }()
    
    lazy var dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .bluePokeAPI
        
        let attributedString = NSMutableAttributedString(string: "Não tem conta? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.white])
        let secondText = NSAttributedString(string: "Cadastre-se!", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white])
        attributedString.append(secondText)
        
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(didTapGoToRegisterScreenButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func didTapButtonLogin() {
        delegate?.didTapButtonLogin()
    }
    
    @objc func didTapGoToRegisterScreenButton() {
        delegate?.didTapGoToRegisterButton()
    }
    
    // MARK: - Methods
    
    func showLoginScreen() {
        delegate?.showLoginScreen()
    }
    
    func showMainScreen() {
        delegate?.showMainScreen()
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    // MARK: - Setup View
    
    private func setHierarchy () {
        backgroundColor = .orangePokeAPI
        
        addSubviews(views: [logoImageView,
                            emailImageView, emailTextfield, emailSeparator,
                            passwordImageView, passwordTextfield, passwordSeparator,
                            loginButton, dontHaveAccountButton])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 250),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            
            emailImageView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 40),
            emailImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailImageView.widthAnchor.constraint(equalToConstant: 40),
            emailImageView.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextfield.centerYAnchor.constraint(equalTo: emailImageView.centerYAnchor),
            emailTextfield.leadingAnchor.constraint(equalTo: emailImageView.trailingAnchor, constant: 10),
            emailTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            
            emailSeparator.topAnchor.constraint(equalTo: emailTextfield.bottomAnchor, constant: 5),
            emailSeparator.leadingAnchor.constraint(equalTo: emailTextfield.leadingAnchor),
            emailSeparator.trailingAnchor.constraint(equalTo: emailTextfield.trailingAnchor),
            emailSeparator.heightAnchor.constraint(equalToConstant: 0.6),
            
            
            passwordImageView.topAnchor.constraint(equalTo: emailSeparator.bottomAnchor, constant: 40),
            passwordImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            passwordImageView.widthAnchor.constraint(equalToConstant: 40),
            passwordImageView.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextfield.centerYAnchor.constraint(equalTo: passwordImageView.centerYAnchor),
            passwordTextfield.leadingAnchor.constraint(equalTo: passwordImageView.trailingAnchor, constant: 10),
            passwordTextfield.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
        
            passwordSeparator.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 5),
            passwordSeparator.leadingAnchor.constraint(equalTo: passwordTextfield.leadingAnchor),
            passwordSeparator.trailingAnchor.constraint(equalTo: passwordTextfield.trailingAnchor),
            passwordSeparator.heightAnchor.constraint(equalToConstant: 0.6),
            
            
            loginButton.topAnchor.constraint(equalTo: passwordSeparator.bottomAnchor, constant: 100),
            loginButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 150),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
            
            dontHaveAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            dontHaveAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            dontHaveAccountButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            dontHaveAccountButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
