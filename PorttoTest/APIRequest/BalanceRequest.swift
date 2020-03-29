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
    var path = "/api.etherscan.io/api"
    var parameters = [String: String]()

    init() {
        parameters["module"] = "account"
        parameters["action"] = "balance"
        parameters["address"] = ownerAddress
        parameters["tag"] = "latest"
    }
}
