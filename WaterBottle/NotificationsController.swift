//
//  NotificationsController.swift
//  WaterBottle
//
//  Created by 张涵雅 on 2/21/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit
import SnapKit


class NotificationsController: UIViewController {
    
    let cellId = "cellId"
    let titleArray = ["Frequency", "Target", "Reminder"]
    
    lazy var newTable: UITableView = {
        let table = UITableView(frame: self.view.frame, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Notifications"
        setupNewTable()
        newTable.tableFooterView = UIView()
//        let tabbar appear
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    //        let tabbar disappear when goes back
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    fileprivate func setupNewTable() {
        view.addSubview(newTable)
        newTable.dataSource = self
        newTable.delegate = self
        
        newTable.snp.makeConstraints { (table) -> Void in
            table.top.equalTo(self.view.snp.top)
            table.left.equalTo(self.view.snp.left)
            table.right.equalTo(self.view.snp.right)
            table.bottom.equalTo(self.view.snp.bottom)
        }
    }
}



//        newTable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        newTable.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//        newTable.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        newTable.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        newTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        newTable.topAnchor.constraint(equalTo: view.topAnchor).isActive = true

