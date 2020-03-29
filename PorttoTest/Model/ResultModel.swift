//
//  ResultModel.swift
//  PorttoTest
//
//  Created by ColdZ on 2020/3/28.
//  Copyright © 2020 ColdZ. All rights reserved.
//

import Foundation

// MARK: - ResultModel
struct ResultModel: Codable {
    let assets: [AssetElement]
}

// MARK: - AssetElement
struct AssetElement: Codable {
    let imageURL: String
    let name: String
    let assetDescription: String
    let permalink: String
    let collection: Collection

    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case name
        case assetDescription = "description"
        case permalink
        case collection
    }
}

// MARK: - Collection
struct Collection: Codable {
    let name: String
}
