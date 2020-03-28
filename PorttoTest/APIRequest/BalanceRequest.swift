//
//  BalanceRequest.swift
//  PorttoTest
//
//  Created by ColdZ on 2020/3/28.
//  Copyright © 2020 ColdZ. All rights reserved.
//

import UIKit

class BalanceRequest: APIRequest {
    var method = RequestType.GET
    var path = "api.opensea.io/api/v1/assets"
    var parameters = [String: String]()

    init() {
        parameters["format"] = "json"
        parameters["owner"] = "0x960DE9907A2e2f5363646d48D7FB675Cd2892e91"
        parameters["offset"] = "0"
        parameters["limit"] = "20"
    }
}
