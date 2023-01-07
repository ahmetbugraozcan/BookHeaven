//
//  BHSplashViewController.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 7.01.2023.
//

import UIKit

class BHSplashViewController: UIViewController {

    let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(loadingIndicator)
        navigationItem.title = "Splash"
        navigationItem.largeTitleDisplayMode = .automatic
        
        addConstraints()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigateToHomeScreen()
    }
    
    
    private func addConstraints(){
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    private func navigateToHomeScreen(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
            self.navigationController?.setViewControllers([BHHomeViewController()], animated: true)
        }
    }
    
}
