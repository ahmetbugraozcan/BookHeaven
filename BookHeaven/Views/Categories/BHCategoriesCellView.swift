//
//  BHCategoriesCell.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 17.01.2023.
//

import UIKit

class BHCategoriesCellView: UICollectionViewCell {
    static let cellReuseIdentifier = "BHCategoriesCellView"

    var text: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        contentView.addSubViews(text)
        addConstraints()
        

    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: centerXAnchor),
            text.centerYAnchor.constraint(equalTo: centerYAnchor),

        ])
    }
    
    func configure(with category: BHCategory){
        self.text.text = category.displayString
    }
    
    override func prepareForReuse() {
        self.text.text = nil
    }
    
    
}
