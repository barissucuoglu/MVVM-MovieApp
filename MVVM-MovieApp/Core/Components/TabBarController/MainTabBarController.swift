//
//  MainTabBarController.swift
//  MVVM-MovieApp
//
//  Created by Barış Sucuoğlu on 29.12.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemPink
        setViewControllers([createHomeNavigationController(), createFavoritesNavigationController()], animated: true)
    }
    

    func createHomeNavigationController() -> UINavigationController {
        let homeVC = HomeScreen()
        homeVC.title = "Popular Movies"
        homeVC.tabBarItem.tag = 0
        homeVC.tabBarItem.image = UIImage(systemName: "movieclapper")
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    
    func createFavoritesNavigationController() -> UINavigationController {
        let favoriteVC = FavoritesListVC()
        favoriteVC.title = "Favorite Movies"
        favoriteVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoriteVC)
    }

}
