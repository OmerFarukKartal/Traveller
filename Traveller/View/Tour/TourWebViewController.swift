import UIKit
import WebKit

class TourWebViewController: UIViewController {

    var viewModel = PayViewModel()
    var webView = WKWebView()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadPaymentURL()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        webView.navigationDelegate = self
        
        activityIndicator.style = .large
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
        let customImage = UIImage(systemName: "xmark.circle")
        let reservationButton = UIBarButtonItem(image: customImage, style: .plain, target: self, action: #selector(reservationButtonTapped))
        reservationButton.tintColor = .black 
        navigationItem.rightBarButtonItem = reservationButton
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ödeme Durumu", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func loadPaymentURL() {
        activityIndicator.startAnimating()
        
        viewModel.loadTourPaymentURL { [weak self] result in
            self?.activityIndicator.stopAnimating()
            switch result {
            case .success(let urlString):
                self?.loadWebView(with: urlString)
            case .failure(let error):
                self?.showAlert(message: "URL Yüklenemedi: \(error.localizedDescription)")
            }
        }
    }
    
    func loadWebView(with urlString: String) {
        guard let url = URL(string: urlString) else {
            showAlert(message: "Geçersiz URL")
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @objc func reservationButtonTapped() {
        tabBarController?.selectedIndex = 0

    }
}

extension TourWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()

    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        showAlert(message: "WebView yüklenemedi: \(error.localizedDescription)")
    }
}
