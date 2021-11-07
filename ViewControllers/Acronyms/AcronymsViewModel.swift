//
//  AcronymsViewModel.swift
//  Acronym
//
//  Created by Praveen, Anand on 11/6/21.
//

import Foundation

class AcronymsViewModel {
    
    struct Constants {
        static let requestKeyText = "sf"
    }
    
    lazy var acronymsAPI = AcronymsListAPI()
    var acronyms: [Acronyms] = []
    
    func getAcronyms(searchText: String, completion: @escaping (Error?) -> Void) {
        var params = [String: String]()
        params[Constants.requestKeyText] = searchText
        
        acronymsAPI.getList(parameters: params) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let data):
                self.acronyms = data
                completion(nil)
                return
            case .error(let error):
                completion(error)
                return
            }
        }
    }
    
    var numberOfAcronyms: Int {
        acronyms.first?.lfs.count ?? 0
    }
    
    func item(for row: Int) -> (title: String, variationCount: Int) {
        guard let item = acronyms.first?.lfs[row] else {
            return ("", 0)
        }
        
        return (item.lf, item.vars.count)
    }
    
    func variations(for row: Int) -> [String] {
        guard let item = acronyms.first?.lfs[row] else {
            return []
        }
        
        return item.vars.map { $0.lf }
    }
    
    func isValidString(text: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".*[^A-Za-z].*", options: [])
            if regex.firstMatch(in: text, options: [], range: NSMakeRange(0, text.count)) != nil {
                return false
            }
        }
        catch {
            print("Regex failed: \(error)")
        }
        
        return true
    }
}
