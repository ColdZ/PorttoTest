//
//  String+ColdZ.swift
//  PorttoTest
//
//  Created by ColdZ on 2020/3/29.
//  Copyright © 2020 ColdZ. All rights reserved.
//

import Foundation

let etherInWei = pow(Decimal(10), 18)

extension String {
    func covertWeiToEther() -> String {
        guard let decimalWei = Decimal(string: self) else {
            return self
        }
        let decimalEther = decimalWei / etherInWei
        return decimalEther.description
    }
}
