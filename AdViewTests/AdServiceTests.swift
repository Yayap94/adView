//
//  AdServiceTests.swift
//  AdViewTests
//
//  Created by Nicolas SABELLA on 07/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import XCTest
@testable import AdView

class AdServiceTests: XCTestCase {

    let adModelService = AdService()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParseJSON() throws {
        if let path = Bundle.main.path(forResource: "AdMock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                adModelService.parseAdModel(jsonData: data)
                XCTAssertEqual(adModelService.getAdModels().count, 2)
                XCTAssertEqual(adModelService.getAdModels()[0].title, "Statue homme noir assis en plâtre polychrome")
            } catch {
                XCTFail()
            }
        }
    }

    func testAscendentSort() {
        if let path = Bundle.main.path(forResource: "AdMock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                adModelService.parseAdModel(jsonData: data)
                let models = adModelService.getAdModelSortByDate(ascendent: true)
                XCTAssert(models[0].creationDate < models[1].creationDate)
            } catch {
                XCTFail()
            }
        }
    }

    func testDescendantSort() {
        if let path = Bundle.main.path(forResource: "AdMock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                adModelService.parseAdModel(jsonData: data)
                let models = adModelService.getAdModelSortByDate(ascendent: false)
                XCTAssert(models[0].creationDate > models[1].creationDate)
            } catch {
                XCTFail()
            }
        }
    }

    func testFilterModel() {
        if let path = Bundle.main.path(forResource: "AdMock", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                adModelService.parseAdModel(jsonData: data)
                let models = adModelService.getFilteredAdModel(for: 4)
                XCTAssertEqual(models.count, 1)
                XCTAssertEqual(models[0].categoryId, 4)
            } catch {
                XCTFail()
            }
        }
    }
}
