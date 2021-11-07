//
//  AcronymHTTPService.swift
//  Acronym
//
//  Created by Praveen, Anand on 11/6/21.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

protocol Requests {
    var url: String { get }
}

protocol AcronymHTTPService {
    func get(request: Requests, method: HTTPMethod, parameters: [String: String]?, completion: @escaping (Result<Data>) -> Void)
}

final class NetworkService: AcronymHTTPService {
    
    func get(request: Requests, method: HTTPMethod, parameters: [String : String]?, completion: @escaping (Result<Data>) -> Void) {
        
        guard let request = updateUrlRequest(request: request, parameters: parameters) else {
            return completion(.error(HTTPServiceError.invalidRequest))
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.error(error))
                return
            }
            
            guard let data = data else {
                completion(.error(HTTPServiceError.invalidData))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
    private func updateUrlRequest(request: Requests, parameters: [String: String]?) -> URLRequest? {
        guard var components = URLComponents(string: request.url), let params = parameters else {
            return nil
        }
        
        for (key, value) in params {
            let item = URLQueryItem(name: key, value: value)
            components.queryItems?.append(item)
        }
        
        guard let url = components.url ?? nil else { return nil }
        
        return URLRequest(url: url)
    }
}

enum HTTPServiceError: Error {
    case invalidRequest
    case invalidData
}
