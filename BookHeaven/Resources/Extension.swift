//
//  Extension.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import UIKit


extension UIView {
    func addSubViews(_ views: UIView...){
        views.forEach { view in
            addSubview(view)
        }
    }
}
