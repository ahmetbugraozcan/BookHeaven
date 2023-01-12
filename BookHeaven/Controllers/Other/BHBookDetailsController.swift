//
//  BHBookDetails.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 10.01.2023.
//

import UIKit

class BHBookDetailsViewController: UIViewController{
    
    var viewModel: BHBooksDetailViewModel
    
    
    var detailsView: BHBookDetailsView
    
    init(viewModel: BHBooksDetailViewModel) {
        self.viewModel = viewModel
        self.detailsView =  BHBookDetailsView(frame: .zero)
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
        
        view.addSubViews(detailsView)
        addConstraints()
        
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            detailsView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailsView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
        ])
    }
    
    func configure(with book: BHBook){
        detailsView.labelTitle.text = viewModel.book.title
        
        detailsView.authorLabel.text = viewModel.book.authors?.first?.name
        detailsView.downloadCountLabel.text = viewModel.book.downloadCount?.description
        BHImageManager.shared.downloadImage(with: viewModel.book.formats.imageJPEG) { result in
            switch result {
            case .success(let success):
                self.detailsView.imageView.image = UIImage(data: success)
                
            case .failure(let failure):
                print("error \(failure.localizedDescription)")
            }
        }
    }
    
}
        
    
        
    
 

