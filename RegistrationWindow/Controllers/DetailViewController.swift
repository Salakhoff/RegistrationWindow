//
//  DetailViewController.swift
//  RegistrationWindow
//
//  Created by Ильфат Салахов on 28.09.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let mainLabel = UILabel()
    private let stackView = UIStackView()
    private let exitButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setupSubviews()
        addTarget()
    }
    
    @objc private func exitButtonTapped() {
        dismiss(animated: true)
    }
}

// MARK: - SetupView
private extension DetailViewController {
    func setupView() {
        view.backgroundColor = .systemCyan
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(mainLabel)
        stackView.addArrangedSubview(exitButton)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            exitButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func setupSubviews() {
        mainLabel.text = "Привет!"
        mainLabel.font = .boldSystemFont(ofSize: 30)
        mainLabel.textAlignment = .center
        mainLabel.textColor = . white
        
        stackView.spacing = 50
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        exitButton.setTitle("Выйти", for: .normal)
        exitButton.backgroundColor = .blue
        exitButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        exitButton.setTitleColor(.white, for: .normal)
        exitButton.layer.cornerRadius = 10
    }
    
    func addTarget() {
        exitButton.addTarget(self, action: #selector(exitButtonTapped), for: .touchUpInside)
    }
}

