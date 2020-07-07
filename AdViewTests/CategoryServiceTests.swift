//
//  CategoryServiceTests.swift
//  AdViewTests
//
//  Created by Nicolas SABELLA on 07/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import XCTest
@testable import AdView

class CategoryServiceTests: XCTestCase {

    let adCategoryService = CategoryService()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParseJSON() throws {
        if let path = Bundle.main.path(forResource: "CategoryMock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                adCategoryService.parseAdModel(jsonData: data)
                XCTAssertEqual(adCategoryService.getAdCategories().count, 11)
                XCTAssertEqual(adCategoryService.getAdCategories()[0].name, "Véhicule")
            } catch {
                XCTFail()
            }
        }
    }

    func testGetCategory() {

        if let path = Bundle.main.path(forResource: "CategoryMock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                adCategoryService.parseAdModel(jsonData: data)
                let vehiculeCategory = adCategoryService.getCategory(for: 0)
                let childrenCategory = adCategoryService.getCategory(for: 11)
                XCTAssertEqual(vehiculeCategory?.categoryId, 0)
                XCTAssertEqual(vehiculeCategory?.name, "Véhicule")
                XCTAssertEqual(childrenCategory?.categoryId, 11)
                XCTAssertEqual(childrenCategory?.name, "Enfants")
            } catch {
                XCTFail()
            }
        }
    }

}
