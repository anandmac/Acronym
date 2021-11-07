//
//  VariationViewModelTests.swift
//  AcronymTests
//
//  Created by Praveen, Anand on 11/7/21.
//

import XCTest
@testable import Acronym

class VariationViewModelTests: XCTestCase {
    
    var viewModel: VariationViewModel!
    
    override func setUp() {
        super.setUp()
        
        let variations = ["somatic mutation and recombination test", "somatic mutation and Recombination test", "Somatic Mutation and Recombination Test"]
        self.viewModel = VariationViewModel(variations: variations)
    }
    
    override func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }
    
    func testNumberOfVariations() {
        let list = self.viewModel.numberOfVariations
        XCTAssertEqual(list, 3, "Expected 3 Variations")
    }
    
    func testTitleItemForRow() {
        let title = self.viewModel.variationName(for: 1)
        XCTAssertEqual(title, "somatic mutation and Recombination test", "Expected somatic mutation and recombination test")
    }
}
