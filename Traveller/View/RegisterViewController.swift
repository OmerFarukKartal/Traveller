import Foundation
import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - UI Elements
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Traveller"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "User Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Name"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Surname"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor.white
        button.tintColor = UIColor.red
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isEnabled = false // Başlangıçta pasif yap
        return button
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        
        // Text alanlarının değişikliklerini izle
        usernameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        surnameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(surnameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(registerButton)
        
        // LogoImageView için içerik modunu belirle (aspect fit)
        logoImageView.contentMode = .scaleAspectFill
        
        let textFieldWidth = view.frame.width * 0.6
        usernameTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: usernameTextField.widthAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: usernameTextField.widthAnchor).isActive = true
        surnameTextField.widthAnchor.constraint(equalTo: usernameTextField.widthAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: usernameTextField.widthAnchor).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        
        nameTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        surnameTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: view.frame.height * 0.05).isActive = true
        registerButton.widthAnchor.constraint(equalTo: usernameTextField.widthAnchor).isActive = true // Butonu text alanlarıyla aynı genişlikte yap
    }
    
    // MARK: - Actions
    
    @objc func registerButtonTapped() {
        guard let username = usernameTextField.text, let password = passwordTextField.text, let name = nameTextField.text, let surname = surnameTextField.text, let email = emailTextField.text  else {
            return
        }
        NetworkManager.shared.register(username: username, password: password, name: name, surname: surname, email: email) { result in
            switch result {
            case .success(let registerResponse):
                print("\(registerResponse.message)")
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
    
    // MARK: - Text Field Change Handler
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        // Tüm text alanları doluysa butonu aktifleştir
        let allFieldsFilled = ![usernameTextField, passwordTextField, nameTextField, surnameTextField, emailTextField].contains { textField in
            return textField.text?.isEmpty ?? true
        }
        registerButton.isEnabled = allFieldsFilled
    }
}
