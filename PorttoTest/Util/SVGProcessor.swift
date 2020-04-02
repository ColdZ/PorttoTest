//
//  SVGProcessor.swift
//  PorttoTest
//
//  Created by ColdZ on 2020/4/2.
//  Copyright © 2020 ColdZ. All rights reserved.
//

import UIKit
import Kingfisher
import SVGKit

struct SVGProcessor: ImageProcessor {
    let imgSize: CGSize?

    init(size: CGSize? = CGSize(width: 500, height: 500)) {
        imgSize = size
    }

    // `identifier` should be the same for processors with same properties/functionality
    // It will be used when storing and retrieving the image to/from cache.
    let identifier = "ColdZ"

    // Convert input data/image to target image and return it.
    func process(item: ImageProcessItem, options: KingfisherParsedOptionsInfo) -> Image? {
        switch item {
        case .image(let image):
            // already an image
            return image
        case .data(let data):
            let imageSVG: SVGKImage? = SVGKImage(data: data)
            return imageSVG?.uiImage ?? DefaultImageProcessor().process(item: item, options: options)
        }
    }
}

struct SVGCacheSerializer: CacheSerializer {
    func data(with image: Image, original: Data?) -> Data? {
        return original
    }

    func image(with data: Data, options: KingfisherParsedOptionsInfo) -> Image? {
        let imageSVG: SVGKImage = SVGKImage(data: data)
        return imageSVG.uiImage
    }
}

