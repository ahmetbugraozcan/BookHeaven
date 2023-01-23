//
//  BHBookDetailsController+Extension.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 21.01.2023.
//

import Foundation
import UIKit

extension BHBookDetailsViewController {
    @objc func addBookToFavorites(){
        viewModel.saveBookToCoreData()
        favoritesViewModel.libraryItems.append(viewModel.book)
        favoritesViewModel.delegate?.didReloadDataRequested()
        
    }
    
    @objc func removeBookFromFavorites(){
        viewModel.removeFromFavorites()
        favoritesViewModel.libraryItems.removeAll { book in book.bookID == viewModel.book.bookID}
        favoritesViewModel.delegate?.didReloadDataRequested()
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
    
    func addToFavoritesButton() -> UIBarButtonItem{
        return UIBarButtonItem(
            image: UIImage(systemName: "heart")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(addBookToFavorites))
    }
    
    func removeFromFavoritesButton() -> UIBarButtonItem{
        return UIBarButtonItem(
            image: UIImage(systemName: "heart.fill")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal),
            style: .plain,
            target: self,
            action: #selector(removeBookFromFavorites))
    }
    
}
