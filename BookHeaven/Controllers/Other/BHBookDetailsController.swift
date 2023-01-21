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
    var scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollview
    }()
    
    var loadingView: UIActivityIndicatorView = {
        var view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.startAnimating()
        
        return view
    }()
    
    init(viewModel: BHBooksDetailViewModel) {
        self.viewModel = viewModel
        self.detailsView =  BHBookDetailsView(frame: .zero)
        detailsView.alpha = 0
        //        detailsView.backgroundColor = .blue
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
        
        scrollView.addSubview(detailsView)
        view.addSubViews(scrollView, loadingView)
        
        viewModel.checkIsBookInFavorites()
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(addBookToFavorites))
        addConstraints()
        
    }
    
    @objc func addBookToFavorites(){
        viewModel.saveBookToCoreData()
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            
            
            detailsView.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailsView.rightAnchor.constraint(equalTo: view.rightAnchor),
            detailsView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            detailsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            //            scrollView.heightAnchor.constraint(equalTo: detailsView.heightAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
    
    func configure(with book: BHBook){
        detailsView.labelTitle.text = viewModel.book.title
        
        detailsView.authorLabel.text = viewModel.book.authors?.first??.name
        detailsView.downloadCountLabel.text = "\(viewModel.book.downloadCount ?? 0) Downloads"
        
        detailsView.downloadButton.addTarget(self, action: #selector(onDownload) , for: .touchUpInside)
        
        
        viewModel.getBookDetails{ [weak self] bookDetailsResponse in
            
            switch bookDetailsResponse{
            case .failure(let error):
                print(String(describing: error))
                
            case .success(let bookDetail):
                
                DispatchQueue.main.async {
                    UIView.animate(withDuration: 0.4, delay: 0) {
                        self?.loadingView.stopAnimating()
                        self?.detailsView.summaryLabel.text = bookDetail.volumeInfo?.description ?? "No summary found"
                        self?.detailsView.pageAndLanguageInfoView.pageCountLabel.text = "\(bookDetail.volumeInfo?.pageCount ?? 0) pages"
                        self?.detailsView.pageAndLanguageInfoView.languageLabel.text = book.getLanguageReadableName()
                        self?.detailsView.alpha = 1
                    }
                    
                }
            }
            
            
        }
        
        BHImageManager.shared.downloadImage(with: viewModel.book.formats.imageJPEG) { result in
            switch result {
            case .success(let success):
                self.detailsView.imageView.image = UIImage(data: success)
                
            case .failure(let failure):
                print("error \(failure.localizedDescription)")
            }
        }
    }
    
    @objc func onDownload(){
        guard let file = viewModel.book.formats.textPlain else {
            return
        }
        self.detailsView.downloadButton.isLoading = true
        let alarm = URL(string: file)!
        do {

            try alarm.download(to: .documentDirectory, overwrite: true) { url, error in
                DispatchQueue.main.async {
                    guard error == nil else {
                        let alert = UIAlertController(title: "Error", message: "Some error occured whie downloading file.", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okAction)
                        self.present(alert, animated: true, completion: nil)
                        
                        self.detailsView.downloadButton.isLoading = false
                        return
                    }
                    
                    let alert = UIAlertController(title: "Successful", message: "File successfully downloaded.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                    self.detailsView.downloadButton.isLoading = false
                }
            }
            
        } catch {
            self.detailsView.downloadButton.isLoading = false
            print(error)
        }
    }
    
}






