//
//  WKWebView+ColdZ.swift
//  PorttoTest
//
//  Created by ColdZ on 2020/3/29.
//  Copyright © 2020 ColdZ. All rights reserved.
//

import UIKit
import WebKit

extension WKWebView {
    public func loadSVG(url: URL) {
        stopLoading()
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {[weak self] (data, response, error) in
            guard let strongSelf = self else { return }
            if let svgString = String(data: data ?? Data(), encoding: .utf8){
                DispatchQueue.main.async {
                    strongSelf.loadHTMLString(svgString, baseURL: Bundle.main.bundleURL)
                }
            }
        }
        task.resume()
    }
}
