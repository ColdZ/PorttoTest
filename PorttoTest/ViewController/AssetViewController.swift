//
//  AssetViewController.swift
//  PorttoTest
//
//  Created by ColdZ on 2020/3/29.
//  Copyright © 2020 ColdZ. All rights reserved.
//

import SafariServices
import UIKit
import WebKit

class AssetViewController: UIViewController {
    var model: AssetElement?
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var webViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionLabelWidthConstraint: NSLayoutConstraint!
    
    var contentWidth: CGFloat {
        return screenWidth - itemMargin * 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshLayout()
    }
    
    func initLayout() {
        navigationItem.title = model?.collection.name
        webView.navigationDelegate = self
        webView.scrollView.isScrollEnabled = false
        webView.contentMode = .scaleAspectFit
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
        
        nameLabel.text = model?.name
        
        descriptionLabel.text = model?.assetDescription
    }
    
    func refreshLayout() {
        
        nameLabelWidthConstraint.constant = contentWidth
        descriptionLabelWidthConstraint.constant = contentWidth
        
        if let size = imageView.image?.size {
            imageViewHeightConstraint.constant = contentWidth * size.height / size.width
        }
    }
    
    @IBAction func didPressBackButton(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didPressLinkButton(_ sender: UIButton) {
        if let permalink = model?.permalink,
            let permalinkURL = URL(string: permalink) {
            let safariViewController = SFSafariViewController(url: permalinkURL)
            present(safariViewController, animated: true)
        }
    }
}

extension AssetViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        self.webView.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                if let view = self.webView.subviews.first?.subviews.first {
                    let contentViewScale = view.transform.a
                    let webViewWidth = self.webView.bounds.width
                    let webViewScale = 520 * contentViewScale / webViewWidth
                    self.webView.scrollView.transform = CGAffineTransform(scaleX: 1 / webViewScale, y: 1 / webViewScale)
                    self.webViewHeightConstraint.constant = self.contentWidth
                }
            }
        })
    }
}
