//
//  TabBarController.swift
//  Traveller
//
//  Created by Ömer Faruk KARTAL on 29.04.2024.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTab()
        
        self.tabBar.tintColor = .black

        
    }
    //MARK: - Tab Setup
    
    private func setupTab() {
        
        let flight = self.createNav(with: "Filght", and: UIImage(systemName: "airplane"), vc: FlightViewController())
        let hotels = self.createNav(with: "Hotels", and: UIImage(systemName: "bed.double"), vc: HotelViewController())
        let tour = self.createNav(with: "Tours", and: UIImage(systemName: "globe.asia.australia.fill"), vc: TourViewController())
        let profile = self.createNav(with: "Profile", and: UIImage(systemName: "person.crop.circle"), vc: ProfileController())

        self.setViewControllers([flight,hotels,tour,profile], animated: true)

        
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image

        
        return nav
        
    }
}
