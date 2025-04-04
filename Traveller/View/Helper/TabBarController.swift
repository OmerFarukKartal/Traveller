import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self  // Delegate'i ayarla
        self.setupTab()
        self.tabBar.tintColor = .black
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    func setupTab() {
        // Başlangıçta boş setViewControllers çağrısı
        self.setViewControllers([], animated: false)
        
        // İlk tabları ayarla
        self.reloadViewControllers()
    }
    
    private func reloadViewControllers() {
        let flight = self.createNav(with: "Flight", and: UIImage(systemName: "airplane"), vc: FlightViewController())
        let hotels = self.createNav(with: "Hotels", and: UIImage(systemName: "bed.double"), vc: HotelViewController())
        let tour = self.createNav(with: "Tours", and: UIImage(systemName: "globe.asia.australia.fill"), vc: TourViewController())
        let blog = self.createNav(with: "Rehber", and: UIImage(systemName: "note.text"), vc: BlogViewController())
        let profile = self.createNav(with: "Profile", and: UIImage(systemName: "person.crop.circle"), vc: ProfileViewController())

        self.setViewControllers([flight, hotels, tour, blog, profile], animated: false)
    }

    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
    

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        // Tab değiştirildiğinde view controller'ları yeniden yükle
        self.reloadViewControllers()
    }
}
