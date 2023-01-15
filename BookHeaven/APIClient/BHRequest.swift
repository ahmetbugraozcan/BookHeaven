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
    
    
    convenience init?(url: URL?,  requestEndPointType: RequestEndPointType = .gutendex){
        guard let url = url else {
            return nil
        }
        let string = url.absoluteString
        
        if !string.contains(requestEndPointType == .gutendex ? Constants.baseURL : Constants.googleEBooksURL){
            return nil
        }
        
        let trimmed = string.replacingOccurrences(of: Constants.baseURL + "/", with: "")
        
        if trimmed.contains("/"){
            let components = trimmed.components(separatedBy: "/")
            if !components.isEmpty{
                let endpointString = components[0]
                var pathComponents: [String] = []
                if components.count > 1 {
                    pathComponents = components
                    pathComponents.removeFirst()
                }
                
                if let rmEndpoint = BHEndpoint(rawValue: endpointString) {
                    self.init(endPoint: rmEndpoint, pathComponents: pathComponents)
                    return
                }
                
            }
            
        }  else if trimmed.contains("?"){
            let components = trimmed.components(separatedBy: "?")
            if !components.isEmpty, components.count >= 2 {
                let endpointString = components[0]
                let queryItemsString = components[1]
                let queryItems:[URLQueryItem] = queryItemsString.components(separatedBy: "&").compactMap({
                    guard $0.contains("=") else {
                        return nil
                    }
                    
                    let parts = $0.components(separatedBy: "=")
                    return URLQueryItem(name: parts[0], value: parts[1])
                })
                
               
                if let rmEndpoint = BHEndpoint(rawValue: endpointString) {
                    self.init(endPoint: rmEndpoint, queryParameters: queryItems)
                    return
                }
            }
        }
        
        return nil
        
        
    }
    
    
    
}
