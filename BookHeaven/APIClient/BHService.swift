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
    
    static func getBookDetailsRequest(with query: String) -> BHRequest {
        var apiKey: String? = nil
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"){
                    if let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
                        let key = dict["GOOGLE_BOOKS_API_KEY"] as? String
                        if(key == nil || key!.isEmpty){
                            apiKey = "DEMO_KEY"
                        } else {
                            apiKey = dict["GOOGLE_BOOKS_API_KEY"] as? String
                        }

                    }
                }
        
       return BHRequest(endPoint: .volumes, queryParameters: [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "startIndex", value: "0"),
            URLQueryItem(name: "maxResults", value: "1"),
        ], requestEndPointType: .google)
    }
 
}
