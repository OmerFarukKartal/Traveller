//
//  LoginViewController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 25.03.2024.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - UI Elements
    
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "traveller"))
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
        button.setTitle("    Giriş Yap    ", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal) // Yazı rengini beyaz yap
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16) // Yazı tipini bold yap
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("    Kayıt Ol    ", for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal) // Yazı rengini beyaz yap
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16) // Yazı tipini bold yap
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
        view.backgroundColor = UIColor.white
        
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .red
        view.addSubview(backgroundView)
        view.addSubview(logoImageView)
        backgroundView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0,paddingLeft: 0, paddingRight: 0, height: screenHeight * 0.3)
        logoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, paddingTop: screenHeight * 0.1, paddingLeft: screenWidth * 0.1, width: screenWidth * 0.8, height: screenHeight * 0.3)
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.addArrangedSubview(registerButton)
        logoImageView.contentMode = .scaleAspectFill
        
        usernameTextField.anchor(top: stackView.topAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1)
        passwordTextField.anchor(top: usernameTextField.bottomAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1)
        loginButton.anchor(top: passwordTextField.bottomAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1)
        registerButton.anchor(top: loginButton.bottomAnchor, left: stackView.leftAnchor, right: stackView.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1)
        
        stackView.anchor(top: logoImageView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor,right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.1)
    }



    
    @objc func loginButtonTapped() {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        APIService.shared.loginUser(username: username, password: password) { result in
            switch result {
            case .success(let loginResponse):
                if let token = loginResponse.token {
                    // Token değerini UserDefaults'a kaydet
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    print("Login successful. Access Token: \(token)")
                }
                DispatchQueue.main.async {
                    if let tabBarController = self.tabBarController as? TabBarController {
                        UIView.transition(with: self.view.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                            tabBarController.selectedIndex = 0
                        }, completion: nil)
                    } else {
                        let tabBarController = TabBarController()
                        tabBarController.selectedIndex = 0
                        UIView.transition(with: self.view.window!, duration: 0.5, options: .transitionCrossDissolve, animations: {
                            self.view.window?.rootViewController = tabBarController
                        }, completion: nil)
                    }
                }
            case .failure(let error):
                print("Login failed. Error: \(error)")
                DispatchQueue.main.async {
                    self.showAlert(title: "Hata", message: "Giriş başarısız. Lütfen kullanıcı adı ve şifrenizi kontrol edin")
                }
            }
        }
    }
    
    @objc func registerButtonTapped() {
        let registerVC = RegisterViewController()
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true, completion: nil)
    }


    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
