//
//  AcronymsListAPI.swift
//  Acronym
//
//  Created by Praveen, Anand on 11/6/21.
//

import Foundation

final class AcronymsListAPI: NSObject {
    
    let service: AcronymHTTPService
    
    convenience override init() {
        self.init(service: NetworkService())
    }
    
    init(service: AcronymHTTPService) {
        self.service = service
    }
    
    func getList(request: Requests = APIRequest.listUrl, method: HTTPMethod = .get, parameters: [String: String], completion: @escaping (Result<[Acronyms]>) -> Void) {
        
        service.get(request: request, method: .get, parameters: parameters) { (data) in
            switch data {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let acronyms = try decoder.decode([Acronyms].self, from: data)
                    guard acronyms.count > 0 else {
                        DispatchQueue.main.async {
                            completion(.error(AcronymsAPIError.noAcronyms))
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(.success(acronyms))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.error(error))
                    }
                }
            case .error(let error):
                DispatchQueue.main.async {
                    completion(.error(error))
                }
            }
        }
    }
}

enum APIRequest: String, Requests {
    case listUrl = "http://www.nactem.ac.uk/software/acromine/dictionary.py?"
    var url: String {
        rawValue
    }
}

enum AcronymsAPIError: Error {
    case noAcronyms
}
