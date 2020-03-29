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

class MainViewController: UIViewController {
    private let apiManager = APIManager()
    private let disposeBag = DisposeBag()
    private let reuseIdentifier = "MainCollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initLayout() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = AssetsRequest()
        let result: Observable<ResultModel> = self.apiManager.send(apiRequest: request)
        result.map{$0.assets}.bind(to: collectionView.rx.items) {[weak self] (collectionView, row, element) in
            guard let strongSelf = self else { return MainCollectionViewCell() }
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: strongSelf.reuseIdentifier,
                                            for: indexPath) as! MainCollectionViewCell
            cell.model = element
            return cell
        }
        .disposed(by: disposeBag)
        
        let balanceRequest = BalanceRequest()
        let balanceResult: Observable<BalanceModel> = self.apiManager.send(apiRequest: balanceRequest)
        balanceResult.map{Optional($0.result.covertWeiToEther())}.bind(to: navigationItem.rx.title)
        .disposed(by: disposeBag)
        
        
        initLayout()
    }
}

