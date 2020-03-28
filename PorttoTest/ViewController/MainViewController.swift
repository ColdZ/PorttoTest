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
    private let cellIdentifier = "MainViewCell"
    private let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLayout()
    }
    
    func initLayout() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = AssetsRequest()
        let result: Observable<ResultModel> = self.apiManager.send(apiRequest: request)
        result.map{$0.assets}.bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) { index, model, cell in
            print(model)
        }
        .disposed(by: disposeBag)
    }
}

