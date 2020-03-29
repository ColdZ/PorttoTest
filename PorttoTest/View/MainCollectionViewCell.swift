//
//  MainCollectionViewCell.swift
//  PorttoTest
//
//  Created by ColdZ on 2020/3/29.
//  Copyright © 2020 ColdZ. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var model: AssetElement? {
        didSet {
            nameLabel.text = model?.name
        }
    }
}
