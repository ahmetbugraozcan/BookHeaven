//
//  BHTabBarController.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import UIKit

/// Controller that contains 4 main tab - Home, Library, Categories, Settings
class BHTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    func setUpTabs(){
        let homeViewController = BHHomeViewController()
        let libraryViewController = BHLibraryViewController()
        let categoriesController = BHCategoriesViewController()
        let settingsController = BHSettingsViewController()
        
        let navHome = UINavigationController(rootViewController: homeViewController)
        let navLib = UINavigationController(rootViewController: libraryViewController)
        let navCat = UINavigationController(rootViewController: categoriesController)
        let navSettings = UINavigationController(rootViewController: settingsController)
        
        for nav in [navHome, navCat, navLib, navSettings] {
            nav.navigationBar.prefersLargeTitles = true
            nav.navigationItem.largeTitleDisplayMode = .automatic
        }
        
        homeViewController.tabBarItem =  UITabBarItem(title: "Home",image: UIImage(systemName: "house"), tag: 1)
        categoriesController.tabBarItem = UITabBarItem(title: "Categories",image: UIImage(systemName: "square.grid.2x2"), tag: 2)
        libraryViewController.tabBarItem = UITabBarItem(title: "Library",image: UIImage(systemName: "books.vertical.fill"), tag: 3)
        settingsController.tabBarItem = UITabBarItem(title: "Settings",image: UIImage(systemName: "gear"), tag: 4)
        
        
        setViewControllers([
            navHome,
            navLib,
            navCat,
            navSettings
        ], animated: true)
    }
    
}
