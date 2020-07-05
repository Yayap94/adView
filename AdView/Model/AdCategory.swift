//
//  AdCategory.swift
//  AdView
//
//  Created by Nicolas SABELLA on 05/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import Foundation

class AdCategory: Codable {
    var categoryId: Int
    var name: String

    enum CodingKeys: String, CodingKey {
        case categoryId = "id"
        case name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        categoryId = try container.decode(Int.self, forKey: .categoryId)
        name = try container.decode(String.self, forKey: .name)
    }
}
