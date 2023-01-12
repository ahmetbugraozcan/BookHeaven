//
//  BHBookDetails.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 10.01.2023.
//

import UIKit

class BHBookDetailsViewController: UIViewController{
    
    var viewModel: BHBooksDetailViewModel
    
    
    var imageView: UIImageView = {
       let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleToFill
        return imageview
    }()
    
    var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        return label
    }()
    
    var bookDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .blue
        label.numberOfLines = 0
        return label
    }()
    
    init(viewModel: BHBooksDetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .never
        configure(with: viewModel.book)
        
        view.addSubViews(imageView,labelTitle,bookDescription )
        
        addConstraints()
        
    }
    
    func configure(with book: BHBook){
        labelTitle.text = viewModel.book.title

        bookDescription.text = viewModel.book.subjects?.joined(separator: ",")
        BHImageManager.shared.downloadImage(with: viewModel.book.formats.imageJPEG) { result in
            switch result {
            case .success(let success):
                self.imageView.image = UIImage(data: success)
                
            case .failure(let failure):
                print("error \(failure.localizedDescription)")
            }
        }
        
    }
    
 
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalToConstant: 400),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: labelTitle.topAnchor),
            
            labelTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            labelTitle.leftAnchor.constraint(equalTo: view.leftAnchor),
//            labelTitle.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            labelTitle.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            bookDescription.leftAnchor.constraint(equalTo: view.leftAnchor),
            bookDescription.rightAnchor.constraint(equalTo: view.rightAnchor),
            bookDescription.topAnchor.constraint(equalTo: labelTitle.bottomAnchor),
            
            
            
            
        ])
    }
}
