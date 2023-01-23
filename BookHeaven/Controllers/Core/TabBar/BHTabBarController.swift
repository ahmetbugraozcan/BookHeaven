//
//  BHTabBarController.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import UIKit
import CoreData
/// Controller that contains 4 main tab - Home, Library, Categories, Settings
class BHTabBarController: UITabBarController {
    let libraryViewModel = BHLibraryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        libraryViewModel.getBooksFromCoreData()
    }
    
   
    func setUpTabs(){
       
        
        let homeViewController = BHHomeViewController(libraryViewModel: libraryViewModel)
        let libraryViewController = BHLibraryViewController(viewModel: libraryViewModel)
        let categoriesController = BHCategoriesViewController(libraryViewModel: libraryViewModel)
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
            navCat,
            navLib,
            
            navSettings
        ], animated: true)
    }
    
}
