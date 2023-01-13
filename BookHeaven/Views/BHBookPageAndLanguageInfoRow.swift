    //
    //  BHBookPageAndDownloadInfoRow.swift
    //  BookHeaven
    //
    //  Created by Ahmet Buğra Özcan on 13.01.2023.
    //

    import UIKit

    /// View that holds specific book's language and page cound
    final class BHBookPageAndLanguageInfoRow: UIStackView{
        
        var languageLabel: UILabel = {
            var lb = UILabel()
            lb.translatesAutoresizingMaskIntoConstraints = false
            
            return lb
        }()
        
        var pageCountLabel: UILabel = {
            var lb = UILabel()
            lb.translatesAutoresizingMaskIntoConstraints = false
            
            return lb
        }()
        var seperatorView: UIView = {
         var sv = UIView()
            sv.translatesAutoresizingMaskIntoConstraints = false
            sv.widthAnchor.constraint(equalToConstant: 1).isActive = true
            sv.backgroundColor = .black
            return sv
            
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.axis = .horizontal
            backgroundColor = UIColor(red: CGFloat(243/255.0), green: CGFloat(239/255.0), blue: CGFloat(237/255.0), alpha: 1)
            // 243 239     237
         
    //        self.layer.cornerRadius = 24
            self.translatesAutoresizingMaskIntoConstraints = false
            self.isLayoutMarginsRelativeArrangement = true
            self.spacing = 10
            self.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
            self.layer.cornerRadius = 12
            addArrangedSubview(languageLabel)
            addArrangedSubview(seperatorView)
            addArrangedSubview(pageCountLabel)
          
            
//            addConstraints()
        }
        
        required init(coder: NSCoder) {
            fatalError("Unsupported")
        }
        
//
//        func addConstraints(){
//            NSLayoutConstraint.activate([
//                seperatorView.widthAnchor.constraint(equalToConstant: 10),
//                seperatorView.heightAnchor.constraint(equalToConstant: 10),
//            ])
//        }
     
        
    }
