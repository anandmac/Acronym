//
//  VariationViewModel.swift
//  Acronym
//
//  Created by Praveen, Anand on 11/6/21.
//

import Foundation

class VariationViewModel: NSObject {
    
    let variations: [String]
    
    init(variations: [String]) {
        self.variations = variations
    }
    
    var numberOfVariations: Int {
        self.variations.count
    }
    
    func variationName(for row: Int) -> String {
        self.variations[row]
    }
}
