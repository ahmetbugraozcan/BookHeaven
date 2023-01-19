//
//  BHLibraryViewController.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import UIKit
import CoreData

class BHLibraryViewController: UIViewController {
    
    var viewModel = BHLibraryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.getBooksFromCoreData()
        title = "Library"
    }


}
