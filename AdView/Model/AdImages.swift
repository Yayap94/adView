//
//  AdImages.swift
//  AdView
//
//  Created by Nicolas SABELLA on 05/07/2020.
//  Copyright © 2020 Nicolas SABELLA. All rights reserved.
//

import Foundation

class AdImages: Codable {
    var smallPicture: String
    var thumbnail: String

    enum CodingKeys: String, CodingKey {
           case smallPicture = "small"
           case thumbnail = "thumb"
       }

       required init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           smallPicture = try container.decodeIfPresent(String.self, forKey: .smallPicture) ?? ""
           thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail) ?? ""
       }
}
