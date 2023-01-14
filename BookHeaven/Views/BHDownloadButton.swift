//
//  BHDownloadButton.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 14.01.2023.
//

import UIKit


final class BHDownloadButton: UIButton{
    
    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.didSetLoading()
            }
        }
    }
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private func didSetLoading(){
        if isLoading {
            self.setImage(nil, for: .normal)
            activityIndicator.startAnimating()
        } else {
            self.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
            activityIndicator.stopAnimating()
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        
        self.tintColor = .white
        
//        self.isUserInteractionEnabled = true
        addSubview(activityIndicator)
        setConstraints()
  
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    
    
    convenience init( buttonType: UIButton.ButtonType = .system) {
           self.init(type: buttonType)
            layer.cornerRadius = 12
            backgroundColor = .systemMint
             
       }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
  
}
