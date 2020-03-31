//
//  MainViewController.swift
//  PorttoTest
//
//  Created by ColdZ on 2020/3/28.
//  Copyright © 2020 ColdZ. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class MainViewController: UIViewController, LoadingIndicatorAbility {
    private let service = AssetsService()
    private let apiManager = APIManager()
    private let disposeBag = DisposeBag()
    private let reuseIdentifier = "MainCollectionViewCell"
    
    var loadingIndicator: LoadingIndicatorView?
    var isLoading: Bool = false
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
        bind()
        bindingService(service)
    }
    
    func initLayout() {
        if let collectionLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let itemWidth = (screenWidth - itemMargin * (mainCollectionViewHorizontalCount + 1)) / mainCollectionViewHorizontalCount
            let itemHeight = (screenHeight - navigationBarHeight - itemMargin * mainCollectionViewVerticalCount) / (mainCollectionViewVerticalCount + 0.7)
            collectionLayout.itemSize = CGSize(width: itemWidth, height: itemHeight)
            collectionLayout.sectionInset = UIEdgeInsets(top: itemMargin, left: itemMargin, bottom: itemMargin, right: itemMargin)
            collectionLayout.minimumLineSpacing = itemMargin
            collectionLayout.minimumInteritemSpacing = itemMargin
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(headerRefresh), for: .valueChanged)
        refreshControl.tintColor = .white
        collectionView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        service.fetchData(isFromStart: true)
    }
    
    func bind() {
        let balanceRequest = BalanceRequest()
        let balanceResult: Observable<BalanceModel> = self.apiManager.send(apiRequest: balanceRequest)
        balanceResult.map{Optional($0.result.covertWeiToEther())}.bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        collectionView.rx.itemSelected.subscribe(onNext: {[weak self] indexPath in
            guard let strongSelf = self else { return }
            let cell = strongSelf.collectionView.cellForItem(at: indexPath) as! MainCollectionViewCell
            let model = cell.model
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            if let assetViewController = mainStoryboard.instantiateViewController(withIdentifier: "AssetViewController") as? AssetViewController {
                assetViewController.model = model
                strongSelf.navigationController?.pushViewController(assetViewController, animated: true)
            }
        }).disposed(by: disposeBag)
    }
    
    private func bindingService(_ service: AssetsService){
        service.updatedLoadingStatus = { [weak self] (isLoading, page) in
            guard let strongSelf = self else { return }
            if isLoading, page == 0 {
                strongSelf.showLoadingIndicator()
            } else {
                strongSelf.hideLoadingIndicator()
            }
        }
        service.updatedDataArray = { [weak self] (newDataArray, page) in
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                if page == 0 {
                    if strongSelf.collectionView.refreshControl?.isRefreshing ?? false {
                        strongSelf.collectionView.refreshControl?.endRefreshing()
                    }
                    strongSelf.collectionView.reloadData()
                } else {
                    let fromIndex = strongSelf.service.dataArray.count - newDataArray.count
                    let toIndex = strongSelf.service.dataArray.count
                    var insertPaths = [IndexPath]()
                    for index in fromIndex..<toIndex{
                        insertPaths.append(IndexPath(row: index, section: 0))
                    }
                    
                    strongSelf.collectionView.performBatchUpdates({
                        strongSelf.collectionView.insertItems(at: insertPaths)
                    })
                }
            }
        }
        service.receivedError = { [weak self] error in
            
        }
    }
    
    @objc func headerRefresh() {
        service.fetchData(isFromStart: true)
        collectionView.refreshControl?.beginRefreshing()
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return service.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MainCollectionViewCell
        if indexPath.row < service.dataArray.count {
            cell.model = service.dataArray[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard indexPath.row == service.dataArray.count - 1 else { return }
        guard !service.isLoading, !service.isLastPage else { return }
        service.fetchData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
}

