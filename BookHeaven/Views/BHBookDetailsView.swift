//
//  BHBookDetailsView.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 12.01.2023.
//

import Foundation
import UIKit

class BHBookDetailsView: UIView{
    
    
    var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .red
        return stackView
    }()
    
    private var spacer = {
        let spacer = UIView(frame: .zero)
        spacer.translatesAutoresizingMaskIntoConstraints = false
        return spacer
    }()
    
    var imageView: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleToFill
        imageview.layer.cornerRadius = 12
        imageview.clipsToBounds = true
        
        return imageview
    }()
    
    var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        
        label.numberOfLines = 2
        
        return label
    }()
    
    var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        
        label.numberOfLines = 3
        return label
    }()
    
    
    var downloadCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = .preferredFont(forTextStyle: .caption1)
        label.numberOfLines = 1
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        horizontalStackView.addArrangedSubview(labelTitle)
        horizontalStackView.addArrangedSubview(authorLabel)
        horizontalStackView.addArrangedSubview(spacer)
        horizontalStackView.addArrangedSubview(downloadCountLabel)
        addSubViews(imageView, horizontalStackView)
        translatesAutoresizingMaskIntoConstraints = false
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.5),
            spacer.heightAnchor.constraint(equalToConstant: 10),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: horizontalStackView.leftAnchor, constant: -20),
            
            horizontalStackView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            horizontalStackView.leftAnchor.constraint(equalTo: imageView.rightAnchor),
            horizontalStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            //
            //
            //            labelTitle.leftAnchor.constraint(equalTo: imageView.rightAnchor),
            //            labelTitle.rightAnchor.constraint(equalTo: rightAnchor),
            //            labelTitle.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            //
            ////            labelTitle.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            //
            //
            //            bookDescription.leftAnchor.constraint(equalTo: labelTitle.leftAnchor),
            //            bookDescription.rightAnchor.constraint(equalTo: labelTitle.rightAnchor),
            //            bookDescription.topAnchor.constraint(equalTo: labelTitle.bottomAnchor),
            //
            
            
            
        ])
    }
}



