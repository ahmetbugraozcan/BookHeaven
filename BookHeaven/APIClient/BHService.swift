//
//  BHService.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import Foundation

final class BHService{
    
    static let shared = BHService()
    
    private init(){}
    
    private enum BHServiceError: Error{
        case failedToCreateRequest
        case failedToGetRequest
    }
    
    func request<T:Codable>(request: BHRequest, expected type: T.Type, completion: @escaping (Result<T,Error>) -> Void) {
        guard let request = self.request(from: request) else {
            completion(.failure(BHServiceError.failedToCreateRequest))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? BHServiceError.failedToCreateRequest))
                return
            }
            
            do{
                let dataToReturn = try JSONDecoder().decode(type.self, from: data)
                completion(.success(dataToReturn))
            } catch {
                completion(.failure(error))
                return
            }
            
        }.resume()
    }
    
    private func request(from request: BHRequest) -> URLRequest? {
        guard let url = request.url else {
            return nil
        }
        
        let urlRequest = URLRequest(url:url)
        return urlRequest
    }
}

extension BHService{
    
    static let getBooksRequest = BHRequest(endPoint: .books)
}
