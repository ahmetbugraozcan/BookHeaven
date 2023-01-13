//
//  BHBookDetailsView.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 12.01.2023.
//

import Foundation
import UIKit

class BHBookDetailsView: UIView{
    
    
    
    var bookInfoColumn: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    
    
    private var spacer = {
        let spacer = UIView(frame: .zero)
        spacer.translatesAutoresizingMaskIntoConstraints = false
        return spacer
    }()
    
    var headerViewContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    var summaryTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title2)
        label.text = "Summary"
        return label
    }()
    
    var summaryLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
 
        label.numberOfLines = 0
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
        bookInfoColumn.addArrangedSubview(labelTitle)
        bookInfoColumn.addArrangedSubview(authorLabel)
        bookInfoColumn.addArrangedSubview(spacer)
        bookInfoColumn.addArrangedSubview(downloadCountLabel)
        
        headerViewContainer.addSubViews(imageView, bookInfoColumn)
        
        
        addSubViews(headerViewContainer,summaryTitle,summaryLabel)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints()
    }
    
    
    required init(coder: NSCoder) {
        fatalError("Unsupported")
    }

    
    func addConstraints(){
        NSLayoutConstraint.activate([

            headerViewContainer.leftAnchor.constraint(equalTo: leftAnchor),
            headerViewContainer.rightAnchor.constraint(equalTo: rightAnchor),
            headerViewContainer.topAnchor.constraint(equalTo: topAnchor),
            headerViewContainer.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 250),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 2.5),
            spacer.heightAnchor.constraint(equalToConstant: 10),
            imageView.topAnchor.constraint(equalTo: headerViewContainer.topAnchor, constant: 30),
            imageView.leftAnchor.constraint(equalTo: headerViewContainer.leftAnchor, constant: 20),
            imageView.rightAnchor.constraint(equalTo: bookInfoColumn.leftAnchor, constant: -20),
            
            bookInfoColumn.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            bookInfoColumn.leftAnchor.constraint(equalTo: imageView.rightAnchor),
            bookInfoColumn.rightAnchor.constraint(equalTo: headerViewContainer.rightAnchor, constant: -20),
            
            
            summaryTitle.leftAnchor.constraint(equalTo: summaryLabel.leftAnchor),
            summaryTitle.rightAnchor.constraint(equalTo: summaryLabel.rightAnchor),
            summaryTitle.topAnchor.constraint(equalTo: headerViewContainer.bottomAnchor, constant: 16),
            summaryTitle.bottomAnchor.constraint(equalTo: summaryLabel.topAnchor),
            
            
            summaryLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor),
            summaryLabel.rightAnchor.constraint(equalTo: rightAnchor),
            summaryLabel.topAnchor.constraint(equalTo:summaryTitle.bottomAnchor, constant: 10),
            summaryLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
            
//            summaryLabel.bottomAnchor.constraint(equalTo: )
            
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



