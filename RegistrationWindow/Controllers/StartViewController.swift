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
    private let bithdayTextField = UITextField()
    private let nicknameTextField = UITextField()
    private var textFields = [UITextField]()
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.preferredDatePickerStyle = .wheels
        
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = Date()
        let minDate = calendar.date(byAdding: .year, value: -100, to: currentDate)
        let maxDate = calendar.date(byAdding: .year, value: -18, to: currentDate)
        datePicker.minimumDate = minDate
        datePicker.maximumDate = maxDate
        return datePicker
    }()
    
    private let toolBar = UIToolbar()
    private var doneButton = UIBarButtonItem()
    
    private let stackView = UIStackView()
    
    private let loginButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setConstraints()
        setupSubviews()
        addTarget()
        workWithNotificationCenter()
    }
    
    @objc private func loginButtonTapped() {
        let allFieldsFilled = areAllTextFieldsFilled()
        
        if allFieldsFilled {
            detailVC.modalPresentationStyle = .fullScreen
            showDetailViewController(detailVC, sender: nil)
        }
        highlightEmptyTextFields()
    }
    
    @objc func doneButtonTapped() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyyг."
        dateFormatter.locale = Locale(identifier: "ru_RU")
        bithdayTextField.text = dateFormatter.string(from: datePicker.date)
        
        nicknameTextField.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - SetupView
private extension StartViewController {
    func setupView() {
        textFields.append(emailTextField)
        textFields.append(passwordTextField)
        textFields.append(bithdayTextField)
        textFields.append(nicknameTextField)
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(mainLabel)
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
        setupTextFields()
        
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
        
        bithdayTextField.placeholder = "Введите ваш возраст..."
        
        nicknameTextField.placeholder = "Введите ваш никнейм..."
        nicknameTextField.autocorrectionType = .no
        nicknameTextField.isUserInteractionEnabled = true
        
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.setTitle("Войти", for: .normal)
        loginButton.backgroundColor = .blue
        loginButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 10
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        bithdayTextField.inputView = datePicker
        bithdayTextField.inputAccessoryView = toolBar
        
        toolBar.sizeToFit()
        doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: self, action: #selector(doneButtonTapped))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([flexibleSpace, doneButton], animated: false)
    }
    
    func addTarget() {
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
}

// MARK: -TextFields
extension StartViewController {
    private func setupTextFields() {
        textFields.forEach { textField in
            stackView.addArrangedSubview(textField)
            textField.borderStyle = .roundedRect
            textField.layer.cornerRadius = 5
            textField.delegate = self
        }
    }
    
    func highlightEmptyTextFields() {
        textFields.forEach { textField in
            if textField.text?.isEmpty ?? true {
                textField.layer.borderColor = UIColor.red.cgColor
                textField.layer.borderWidth = 1.0
            } else {
                textField.layer.borderColor = nil
                textField.layer.borderWidth = 0
            }
        }
    }
    
    func areAllTextFieldsFilled() -> Bool {
        return textFields.allSatisfy { textField in
            if let text = textField.text, !text.isEmpty {
                return true
            }
            return false
        }
    }
}


// MARK: -UITextFieldDelegate
extension StartViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailTextField: passwordTextField.becomeFirstResponder()
        case passwordTextField: bithdayTextField.becomeFirstResponder()
        case bithdayTextField: nicknameTextField.becomeFirstResponder()
        case nicknameTextField: nicknameTextField.resignFirstResponder()
        default: break
        }
        
        return true
    }
}

// MARK: -NotificationCenter
extension StartViewController {
    private func workWithNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            guard let lastTextField = textFields.last else { return }
            let lastTextFieldFrame = lastTextField.convert(lastTextField.bounds, to: self.view)
            let offset = max(0, (lastTextFieldFrame.maxY + 10) - keyboardSize.origin.y)
            
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self else { return }
                self.view.transform = CGAffineTransform(translationX: 0, y: -offset)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.view.transform = .identity
        }
    }
}
