//
//  BHRequest.swift
//  BookHeaven
//
//  Created by Ahmet Buğra Özcan on 8.01.2023.
//

import Foundation

final class BHRequest{
    
    
    init(
        endPoint: BHEndpoint,
        queryParameters: [URLQueryItem] = [],
        pathComponents:[String] = []
    ) {
        self.endPoint = endPoint
        self.queryParameters = queryParameters
        self.pathComponents = pathComponents
    }
    
    
    private struct Constants{
        static let baseURL = "https://gutendex.com"
    }
    
    private var queryParameters: [URLQueryItem] = []
    private var pathComponents: [String] = []
    private let endPoint: BHEndpoint
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    
    private var urlString: String{
        var url = Constants.baseURL
        url += "/"
        url += endPoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach { component in
                url += "/\(component)"
            }
        }
        
        if !queryParameters.isEmpty {
            url += "?"
            let argumentString = queryParameters.compactMap { queryItem in
                guard let value = queryItem.value else {
                    return nil
                }
                
                return "\(queryItem.name)=\(value)"
            }.joined(separator: "&")
            
            url += argumentString
        }
        
        return url
    }
    
    
    
}
