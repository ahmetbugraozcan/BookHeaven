//
//  BHCategoryViewController.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 17.01.2023.
//

import UIKit


class BHCategoryViewController: UIViewController{
    var category: BHCategory
    
    init(category: BHCategory) {
        self.category = category
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        self.title = category.displayString
        
    }
    
}
