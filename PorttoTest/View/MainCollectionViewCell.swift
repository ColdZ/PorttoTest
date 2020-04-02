//
//  MainCollectionViewCell.swift
//  PorttoTest
//
//  Created by ColdZ on 2020/3/29.
//  Copyright © 2020 ColdZ. All rights reserved.
//

import Kingfisher
import UIKit
import WebKit

class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var model: AssetElement? {
        didSet {
            nameLabel.text = model?.name
            if let imageURLString = model?.imageURL,
                let imageURL = URL(string: imageURLString) {
                if imageURL.lastPathComponent.contains("svg") {
                    imageView.kf.setImage(with: imageURL, options: [.processor(SVGProcessor())])
                } else {
                    imageView.kf.setImage(with: imageURL, options: nil)
                }
            }
        }
    }
}
