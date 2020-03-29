//
//  UIColor+Groutag.swift
//  Groutag
//
//  Created by cheng-en wu on 7/24/19.
//  Copyright © 2019 Laixion. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }

    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
    ///#282828
    static let primaryGray = UIColor(named: "primaryGray")!
    ///#303030
    static let gp_SecondaryGray = UIColor(hex: 0x303030)
    ///#ef7575
    static let buttonPink = UIColor(named: "buttonPink")!
    ///#c8c8c8
    static let gp_DisableGray = UIColor(hex: 0xc8c8c8)
    ///#edb45f
    static let gp_Yellow = UIColor(hex: 0xedb45f)
    ///#efcf6e
    static let gp_TrimmerYellow = UIColor(named: "gp_TrimmerYellow")!
    ///#9b9b9b
    static let gp_PlaceholderGray = UIColor(named: "gp_PlaceholderGray")!
    ///#39393a
    static let gp_TableViewCellSeparatorGray = UIColor(named: "gp_TableViewCellSeparatorGray")!
    ///#cd5651
    static let gp_SegmentSelectedRed = UIColor(named: "gp_SegmentSelectedRed")!
    ///#bdbdbd alpha:0.8
    static let gp_ProcessGray = UIColor(named: "gp_ProcessGray")!
    ///#212121
    static let gp_Gray33 = UIColor(named: "gp_Gray33")!
    ///#
    static let gp_Gray61 = UIColor(named: "gp_Gray61")!
    ///#4a4a4a
    static let gp_Gray74 = UIColor(named: "gp_Gray74")!
    ///#6d6d6d
    static let gp_Gray109 = UIColor(named: "gp_Gray109")!
    ///#cd5651
    static let gp_ButtonTitleRed = UIColor(named: "gp_ButtonTitleRed")!
    ///#fcf15d
    static let gp_RecordClipYellow = UIColor(named: "gp_RecordClipYellow")!
    ///#6c6c6c
    static let gp_RankGrey = UIColor(hex: 0x6c6c6c)
}
