//
//  BHFooterLoadingView.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 15.01.2023.
//

import Foundation

import UIKit

class BHFooterLoadingView: UICollectionReusableView {
    static let identifier = "BHFooterLoadingReusableView"
    private let spinner: UIActivityIndicatorView = {
       let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(spinner)
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    public func startAnimating(){
        spinner.startAnimating()
    }
}
