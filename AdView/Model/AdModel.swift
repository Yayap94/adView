//
//  AdModel.swift
//  AdView
//
//  Created by Nicolas SABELLA on 02/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import Foundation

class AdModel: Codable {
    let id: Int
    let title: String
    let desc: String
    let price: Int
    let categoryId: Int
    let isUrgent: Bool
    let images: AdImages
    let creationDate: Date

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case categoryId = "category_id"
        case desc = "description"
        case images = "images_url"
        case isUrgent = "is_urgent"
        case creationDate = "creation_date"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        title = try container.decode(String.self, forKey: .title)
        categoryId = try container.decode(Int.self, forKey: .categoryId)
        price = try container.decode(Int.self, forKey: .price)
        desc = try container.decode(String.self, forKey: .desc)
        isUrgent = try container.decode(Bool.self, forKey: .isUrgent)
        images = try container.decode(AdImages.self, forKey: .images)
        let dateStr = try container.decode(String.self, forKey: .creationDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        creationDate = dateFormatter.date(from: dateStr) ?? Date()
    }
}
