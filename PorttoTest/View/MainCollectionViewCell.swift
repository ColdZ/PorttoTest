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
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var model: AssetElement? {
        didSet {
            nameLabel.text = model?.name
            if let imageURLString = model?.imageURL,
                let imageURL = URL(string: imageURLString) {
                if imageURL.lastPathComponent.contains("svg") {
                    imageView.isHidden = true
                    webView.isHidden = false
                    webView.loadSVG(url: imageURL)
                } else {
                    webView.isHidden = true
                    imageView.isHidden = false
                    imageView.kf.setImage(with: imageURL, options: nil)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
        webView.contentMode = .scaleAspectFit
    }
    
    deinit {
        webView.stopLoading()
    }
}

extension MainCollectionViewCell: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
      didFinish navigation: WKNavigation!) {
        
    }
}
