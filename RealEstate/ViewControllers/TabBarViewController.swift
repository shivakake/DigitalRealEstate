//
//  TabBarViewController.swift
//  RealEstate
//
//  Created by PGK Shiva Kumar on 11/05/23.
//

import UIKit
import ComponentUI

class TabBarViewController: UITabBarController {
    
    let styleLibrary = StyleLibrary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func setupTabBar() {
        
        let profileViewController = InstallmentsViewController()
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        let profileTabBarItemIcon = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        profileNavigationController.tabBarItem = profileTabBarItemIcon
        
        let visitsViewController = VisitsViewController()
        let visitsNavigationController = UINavigationController(rootViewController: visitsViewController)
        let visitsTabBarItemIcon = UITabBarItem(title: "Visits", image: UIImage(systemName: "cart"), selectedImage: UIImage(systemName: "cart.fill"))
        visitsNavigationController.tabBarItem = visitsTabBarItemIcon
        
        let supportViewController = SupportViewController()
        let supportNavigationController = UINavigationController(rootViewController: supportViewController)
        let supportTabBarItemIcon = UITabBarItem(title: "Support", image: UIImage(systemName: "text.bubble"), selectedImage: UIImage(systemName: "text.bubble.fill"))
        supportNavigationController.tabBarItem = supportTabBarItemIcon
        
        let likedViewController = LikedViewController()
        let likedNavigationController = UINavigationController(rootViewController: likedViewController)
        let likedTabBarItemIcon = UITabBarItem(title: "Likes", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        likedNavigationController.tabBarItem = likedTabBarItemIcon
        
        let homeViewController = HomeViewController()
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        let homeTabBarItemIcon = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        homeNavigationController.tabBarItem = homeTabBarItemIcon
        
        //MARK: Array of the root view controllers displayed by the tab bar interface
        tabBar.tintColor = styleLibrary.appColor
        self.viewControllers = [homeNavigationController ,likedNavigationController, supportNavigationController, visitsNavigationController, profileNavigationController]
    }
}
