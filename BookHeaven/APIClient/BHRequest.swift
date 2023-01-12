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
        pathComponents:[String] = [],
        requestEndPointType: RequestEndPointType = .gutendex
    ) {
        self.endPoint = endPoint
        self.queryParameters = queryParameters
        self.pathComponents = pathComponents
        self.requestEndPointType = requestEndPointType
    }
    
    
    enum RequestEndPointType{
        case google
        case gutendex
    }
    
    private struct Constants{
        static let baseURL = "https://gutendex.com"
        /// "${GOOGLE_BOOKS_URL}?q=$encodedName&startIndex=0&maxResults=1&apiKey=$GOOGLE_API_KEY"
        static let googleEBooksURL = "https://www.googleapis.com/books/v1"
    }
    
    private var queryParameters: [URLQueryItem] = []
    private var pathComponents: [String] = []
    private let endPoint: BHEndpoint
    private let requestEndPointType: RequestEndPointType
    
    public var url: URL? {
        return URL(string: urlString)
    }
    
    
    private var urlString: String{
        var url = requestEndPointType == .gutendex ? Constants.baseURL : Constants.googleEBooksURL
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
                
                return "\(queryItem.name)=\(value.replacingOccurrences(of: " ", with: "%20"))"
            }.joined(separator: "&")
            
            url += argumentString
        }
        
        return url
    }
    
    
    
}
