//
//  CategoryService.swift
//  AdView
//
//  Created by Nicolas SABELLA on 05/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import Foundation

class CategoryService {
    private var adCategories: [AdCategory] = []
    private let networkService = NetworkService()
    private let adCategoryUrl = "https://raw.githubusercontent.com/leboncoin/paperclip/master/categories.json"

    func getAllAdCategories() {
        networkService.loadJson(fromURLString: adCategoryUrl) { (result) in
            switch result {
            case .success(let data):
                self.parseAdModel(jsonData: data)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func parseAdModel(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([AdCategory].self, from: jsonData)
            if decodedData.count > 0 {
                adCategories = decodedData
            }
        } catch {
            print("decode error")
        }
    }

    func getAdCategories() -> [AdCategory] {
        return adCategories
    }

    func getCategory(for id: Int) -> AdCategory? {
        return adCategories.first { $0.categoryId == id }
    }
}
