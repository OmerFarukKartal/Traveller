//
//  LoginViewController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 25.03.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    // MARK: - UI Elements
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Traveller"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Kullanıcı Adı"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Şifre"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Giriş Yap", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        
        view.backgroundColor = UIColor.red
        
        let logoWidth = view.frame.width * 0.6
        let logoHeight = view.frame.height * 0.2
        
        logoImageView.widthAnchor.constraint(equalToConstant: logoWidth).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: logoHeight).isActive = true
        
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        
        
        // LogoImageView için içerik modunu belirle (aspect fit)
        logoImageView.contentMode = .scaleAspectFill
        
        let textFieldWidth = view.frame.width * 0.6
        usernameTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: usernameTextField.widthAnchor).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        usernameTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
    }
    
    
    
    @objc func loginButtonTapped() {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        APIService.shared.loginUser(username: username, password: password) { result in
            switch result {
            case .success(let loginResponse):
                print("Login successful. Access Token: \(loginResponse.token ?? "")")
                
                
                DispatchQueue.main.async {
                    let flightVC = FlightViewController()
                    self.navigationController?.pushViewController(flightVC, animated: true)
                }
            case .failure(let error):
                print("Login failed. Error: \(error)")
                DispatchQueue.main.async {
                    self.showAlert(title: "Hata", message: "Giriş başarısız. Lütfen kullanıcı adı ve şifrenizi kontrol edin")
                }
            }
        }
    }
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
