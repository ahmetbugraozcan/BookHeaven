//
//  ImageManager.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 9.01.2023.
//

import Foundation
import UIKit

final class BHImageManager {
    
    let cache = NSCache<NSString, NSData>()
    
    static let shared = BHImageManager()
    
    private init(){}
    
    func downloadImage(with imageLink: String?, completion: @escaping (Result<Data,Error>) -> Void) {
      
        guard let imageLink = imageLink else {
            completion(.failure(ImageManagerErrors.nilLink))
            return
        }
        
        if let imageData = cache.object(forKey: imageLink as NSString){
            completion(.success(imageData as Data))
            return
        }
        
        guard let url = URL(string: imageLink) else {
            completion(.failure(ImageManagerErrors.corruptedURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) {[weak self] data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? ImageManagerErrors.failedToDownload))
                return
            }
            
            self?.cache.setObject(data as NSData, forKey: imageLink as NSString)
            completion(.success(data))
        }.resume()
        
        
    }
    
    private enum ImageManagerErrors: Error{
        case failedToDownload
        case corruptedURL
        case nilLink
    }
}
