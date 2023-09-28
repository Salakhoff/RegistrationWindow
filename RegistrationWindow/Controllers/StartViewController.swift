//
//  ViewController.swift
//  RegistrationWindow
//
//  Created by Ильфат Салахов on 28.09.2023.
//

import UIKit

class StartViewController: UIViewController {
    
    private let detailVC = DetailViewController()
    
    private let mainLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let ageTextField = UITextField()
    private let nicknameTextField = UITextField()
    private let stackView = UIStackView()
    
    private let loginButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setupSubviews()
        addTarget()
    }
    
    @objc private func loginButtonTapped() {
        detailVC.modalPresentationStyle = .fullScreen
        showDetailViewController(detailVC, sender: nil)
    }
}

// MARK: - SetupView
private extension StartViewController {
    func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(ageTextField)
        stackView.addArrangedSubview(nicknameTextField)
        view.addSubview(loginButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            loginButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupSubviews() {
        mainLabel.text = "Регистрация"
        mainLabel.font = .boldSystemFont(ofSize: 20)
        mainLabel.textAlignment = .center
        
        emailTextField.placeholder = "Введите email..."
        emailTextField.autocorrectionType = .no
        emailTextField.isUserInteractionEnabled = true
        emailTextField.keyboardType = .asciiCapable
        
        passwordTextField.placeholder = "Введите пароль..."
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.isSecureTextEntry = true
        passwordTextField.autocorrectionType = .no
        passwordTextField.isUserInteractionEnabled = true
        
        ageTextField.placeholder = "Введите ваш возраст..."
        
        nicknameTextField.placeholder = "Введите ваш никнейм..."
        nicknameTextField.autocorrectionType = .no
        nicknameTextField.isUserInteractionEnabled = true
        
        emailTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        ageTextField.borderStyle = .roundedRect
        nicknameTextField.borderStyle = .roundedRect
        
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addTarget() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

