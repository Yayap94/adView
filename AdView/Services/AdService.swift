//
//  AdService.swift
//  AdView
//
//  Created by Nicolas SABELLA on 05/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import Foundation

class AdService {
    private var adModels: [AdModel] = []
    private let networkService = NetworkService()
    private let adModelsUrl = "https://raw.githubusercontent.com/leboncoin/paperclip/master/listing.json"

    func getAllAdModels() {
        networkService.loadJson(fromURLString: adModelsUrl) { (result) in
            switch result {
            case .success(let data):
                self.parseAdModel(jsonData: data)
                NotificationCenter.default.post(name: Notification.Name("DataUpdated"), object: nil)
            case .failure(let error):
                print(error)
            }
        }
    }

    func parseAdModel(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode([AdModel].self, from: jsonData)
            if decodedData.count > 0 {
                adModels = decodedData
            }
        } catch {
            print("decode error")
        }
    }

    func getAdModels() -> [AdModel] {
        return adModels
    }

    func getAdModelSortByDate(ascendent: Bool,
                              for adModelsToSort: [AdModel]? = nil) -> [AdModel] {
        let models = adModelsToSort == nil ? adModels : adModelsToSort!
        return models.sorted { (leftAd, rightAd) in
            if ascendent {
                return leftAd.creationDate < rightAd.creationDate
            } else {
                return leftAd.creationDate > rightAd.creationDate
            }
        }.sorted { (leftAd, rightAd) in
            return leftAd.isUrgent && !rightAd.isUrgent
        }
    }

    func getFilteredAdModel(for categoryId: Int,
                            in adModelsToFilter: [AdModel]? = nil) -> [AdModel] {
        let models = adModelsToFilter == nil ? adModels : adModelsToFilter!
        return models.filter { $0.categoryId == categoryId }
    }
}
