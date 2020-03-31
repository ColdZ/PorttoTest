//
//  AssetsRequest.swift
//  PorttoTest
//
//  Created by ColdZ on 2020/3/28.
//  Copyright © 2020 ColdZ. All rights reserved.
//

import UIKit

class AssetsRequest: APIRequest {
    let method = RequestType.GET
    let path = "/api.opensea.io/api/v1/assets"
    var parameters = [String: String]()

    init(offset: Int) {
        parameters["format"] = "json"
        parameters["owner"] = ownerAddress
        parameters["offset"] = String(offset)
        parameters["limit"] = String(assetsServiceLimit)
    }
}
