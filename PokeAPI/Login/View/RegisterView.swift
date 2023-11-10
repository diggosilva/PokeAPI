//
//  RegisterView.swift
//  PokeAPI
//
//  Created by Diggo Silva on 08/11/23.
//

import UIKit
import FirebaseAuth
import FirebaseCore

// MARK: - Protocols

protocol RegisterViewDelegate: AnyObject {
    func didTapGoToLoginButton()
    func didTapRegisterButton()
}

class RegisterView: UIView {
    
    weak var delegate: RegisterViewDelegate?
    
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
        Factory.buildTextField(placeholder: "Email", keyboardType: .emailAddress)
    }()
    
    lazy var emailSeparator: UIView = {
        Factory.buildSeparator()
    }()
    
    lazy var passwordImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "lock.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var passwordTextfield: UITextField = {
        Factory.buildTextField(placeholder: "Senha", keyboardType: .default, isSecureTextEntry: true)
    }()
    
    lazy var passwordSeparator: UIView = {
        Factory.buildSeparator()
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.titleLabel?.font = .monospacedSystemFont(ofSize: 24, weight: .bold)
        button.layer.cornerRadius = 8
        button.tintColor = .yellowPokeAPI
        button.backgroundColor = .orangePokeAPI
        button.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
        return button
    }()
    
    lazy var haveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .bluePokeAPI
        
        let attributedString = NSMutableAttributedString(string: "Já tem uma conta? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.white])
        let secondText = NSAttributedString(string: "Logar!", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .bold), NSAttributedString.Key.foregroundColor : UIColor.white])
        attributedString.append(secondText)
        
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(didTapGoToLoginButton), for: .touchUpInside)
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
    
    
    @objc func didTapRegisterButton() {
        print("Clicou no botão")
        delegate?.didTapRegisterButton()
    }
    
    @objc func didTapGoToLoginButton() {
        delegate?.didTapGoToLoginButton()
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy () {
        backgroundColor = .bluePokeAPI
        
        addSubview(logoImageView)
        
        addSubview(emailImageView)
        addSubview(emailTextfield)
        addSubview(emailSeparator)

        addSubview(passwordImageView)
        addSubview(passwordTextfield)
        addSubview(passwordSeparator)
        
        addSubview(registerButton)
        addSubview(haveAccountButton)
        
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
            
            
            registerButton.topAnchor.constraint(equalTo: passwordSeparator.bottomAnchor, constant: 100),
            registerButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 150),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
            
            haveAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            haveAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            haveAccountButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            haveAccountButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
