//
//  AssetsService.swift
//  PorttoTest
//
//  Created by ColdZ on 2020/3/31.
//  Copyright © 2020 ColdZ. All rights reserved.
//

import UIKit

class AssetsService: NSObject {
    let manager = APIManager()
    var dataArray: [AssetElement] = []
    var page: Int = 0 {
        didSet{
            previousPage = oldValue
        }
    }
    private var previousPage: Int = 0
    var isLoading: Bool = false {
        didSet{
            updatedLoadingStatus(isLoading, page)
        }
    }
    var isLastPage = false
    
    var updatedLoadingStatus: ((Bool, _ page: Int) -> Void)!
    var updatedDataArray: ((_ newDataArray: [AssetElement], _ page: Int) -> ())!
    var receivedError: ((Error) -> Void)!
    
    //MARK: Main feature
    func reset() {
        page = 0
        isLastPage = false
        dataArray.removeAll()
    }
    
    func fetchData(isFromStart: Bool = false) {
        let nextPage: Int
        if isFromStart {
            nextPage = 0
        } else {
            guard !isLastPage else { return }
            nextPage = page + assetsServiceLimit
        }
        
        let request = AssetsRequest(offset: nextPage)
        page = nextPage
        isLoading = true
        
        manager.send(apiRequest: request, completion: {[weak self] data in
            guard let strongSelf = self else { return }
            if isFromStart {
                strongSelf.reset()
            }
            strongSelf.isLoading = false
            do {
                let model = try JSONDecoder().decode(ResultModel.self, from: data)
                strongSelf.dataArray.append(contentsOf: model.assets)
                if model.assets.count == 0 {
                    strongSelf.isLastPage = true
                }
                strongSelf.updatedDataArray(model.assets, strongSelf.page)
            } catch let error {
                strongSelf.receivedError(error)
            }
        })
    }
}
