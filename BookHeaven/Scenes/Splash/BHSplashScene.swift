//
//  SplashScreen.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 7.01.2023.
//

import UIKit

class BHSplashScene: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstraint()
        backgroundColor = .systemRed
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraint() {
        
    }

}
