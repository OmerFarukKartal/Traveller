import UIKit
import WebKit

class FlightReservationViewController: UIViewController, WKNavigationDelegate {
    
    var flightID: Int?
    var webView: WKWebView?
    var viewModel = FlightViewModel()
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    let yolcuInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Yolcu Bilgileri"
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "İsim Yazınız"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    let surnameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Soyisim Yazınız"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email Yazınız"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Telefon Numarası "
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    let yasTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Yaşınızı Yazınız"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.black.cgColor
        textField.keyboardType = .numberPad
        textField.layer.borderWidth = 1.0
        textField.layer.cornerRadius = 8
        return textField
    }()

    
    let odemeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("  Ödeme Yap  ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(odemeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        print(flightID ?? 0)
        self.navigationItem.title = ""
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
                view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
            view.endEditing(true)
        }
    func setupUI () {
        view.backgroundColor = .white
        
        // Title StackView
        let titleStackView = UIStackView()
        titleStackView.backgroundColor = .red
        titleStackView.axis = .vertical
        titleStackView.distribution = .fill
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleStackView)
        
        titleStackView.anchor(top: view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingRight: 0, height: screenHeight * 0.15)
        
        let titleLabel = UILabel()
        titleLabel.text = "TRAVELLER"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 45, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleStackView.addSubview(titleLabel)
        titleLabel.anchorToCenterX(of: titleStackView)
        titleLabel.anchorToBottom(of: titleStackView)
        
        
        view.addSubview(yolcuInfoLabel)
        yolcuInfoLabel.anchor(top: titleStackView.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingLeft: screenWidth * 0.37, paddingRight: screenWidth * 0.29)
        
        let rezervasyonCizgi = UIView()
        rezervasyonCizgi.translatesAutoresizingMaskIntoConstraints = false
        rezervasyonCizgi.backgroundColor = .black
        view.addSubview(rezervasyonCizgi)
        rezervasyonCizgi.anchor(top: yolcuInfoLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.05, paddingRight: screenWidth * 0.05, height: 1)
        

        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.borderWidth = 1.0
        containerView.layer.cornerRadius = 8
        containerView.layer.borderColor = UIColor.black.cgColor
        view.addSubview(containerView)
        containerView.anchor(top: rezervasyonCizgi.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.01, paddingLeft: screenWidth * 0.05, paddingRight: screenWidth * 0.02, height: screenHeight * 0.42)
        
        
        containerView.addSubview(nameTextField)
        nameTextField.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: screenHeight * 0.025, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.3)
        
        containerView.addSubview(surnameTextField)
        surnameTextField.anchor(top: nameTextField.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: screenHeight * 0.04, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.3)
        
        containerView.addSubview(emailTextField)
        emailTextField.anchor(top: surnameTextField.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: screenHeight * 0.04, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.3)
        
        containerView.addSubview(phoneTextField)
        phoneTextField.anchor(top: emailTextField.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: screenHeight * 0.04, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.3)
        
        containerView.addSubview(yasTextField)
        yasTextField.anchor(top: phoneTextField.bottomAnchor, left: containerView.leftAnchor, right: containerView.rightAnchor, paddingTop: screenHeight * 0.04, paddingLeft: screenWidth * 0.1, paddingRight: screenWidth * 0.3)
        view.addSubview(odemeButton)
        odemeButton.anchor(top: containerView.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: screenHeight * 0.02, paddingRight: screenWidth * 0.02)
        

        
    }
    
    @objc func odemeButtonTapped() {
        let flightID = flightID
        guard let name = nameTextField.text,
              let surname = surnameTextField.text,
              let phone = phoneTextField.text,
              let email = emailTextField.text,
              let age = yasTextField.text
        else {
            displayErrorAlert(message: "Lütfen Tüm Alanları Doldurun.")
            return
        }
        
        viewModel.crateFlightReservation(name: name, surname: surname, phone: phone, email: email, flightId: flightID!, age: age) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let success):
                print(success.message)
                let vc = FlightWebViewViewController()
                navigationController?.pushViewController(vc, animated: true)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }


    private func displayErrorAlert(message: String) {
        let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
