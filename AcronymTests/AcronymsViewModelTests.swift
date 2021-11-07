//
//  AcronymsViewModelTests.swift
//  AcronymTests
//
//  Created by Praveen, Anand on 11/6/21.
//

import XCTest
@testable import Acronym

class AcronymsViewModelTests: XCTestCase {
    
    var viewModel: AcronymsViewModel!
    var acronym: Acronyms!
    
    override func setUp() {
        super.setUp()
        
        self.viewModel = AcronymsViewModel()
        
        let var1 = Vars(lf: "test and lear", freq: 1, since: 1990)
        let var2 = Vars(lf: "test And Learn", freq: 1, since: 1990)
        let lfs = Lfs(lf: "test and lear", freq: 2, since: 1990, vars: [var1, var2])
        let lfs2 = Lfs(lf: "test and like", freq: 1, since: 1990, vars: [])
        acronym = Acronyms(sf: "tal", lfs: [lfs, lfs2])
    
        viewModel.acronyms = [acronym]
    }
    
    override func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }
    
    func testEnterTextContainNumber() {
        let isValid = viewModel.isValidString(text: "1234")
        XCTAssertFalse(isValid, "Enter text contain numbers and not valid.")
    }
    
    func testEnterTextContainSpecialCharacters() {
        let isValid = viewModel.isValidString(text: "$@#")
        XCTAssertFalse(isValid, "Enter text contain specialCharacters and not valid.")
    }
    
    func testEnterTextContainSpace() {
        let isValid = viewModel.isValidString(text: " ")
        XCTAssertFalse(isValid, "Enter text contain space and not valid.")
    }
    
    func testEnterTextContainOnlyCharacters() {
        let isValid = viewModel.isValidString(text: "ASD")
        XCTAssertTrue(isValid, "Enter text contain characters and valid.")
    }
    
    func testNumberOfAcronyms() {
        let list = self.viewModel.numberOfAcronyms
        XCTAssertEqual(list, 2, "Expected 2 Acronyms")
    }
    
    func testTitleItemForRow() {
        let title = self.viewModel.item(for: 1).title
        XCTAssertEqual(title, "test and like", "Expected test and like Variations")
    }
    
    func testNumberOfVariations() {
        let variations = self.viewModel.variations(for: 0).count
        XCTAssertEqual(variations, 2, "Expected 2 Variations")
    }
    
    func testVariationName() {
        let variationName = self.viewModel.variations(for: 0)[1]
        XCTAssertEqual(variationName, "test And Learn", "Expected 2 Variations")
    }
}
