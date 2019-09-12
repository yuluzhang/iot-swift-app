//
//  FrequencyController.swift
//  WaterBottle
//
//  Created by 张涵雅 on 2/21/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit
import SnapKit


class FrequencyController: UIViewController {
    
    let cellId = "cellId"
    let titleArray = ["Per 2 hours", "Per 3 hours", "Per 4 hours", "Per 5 hours", "No need"]
    
    lazy var newTable: UITableView = {
        let table = UITableView(frame: self.view.frame, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Frequency"
        setupNewTable()
        newTable.tableFooterView = UIView()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    
    fileprivate func setupNewTable() {
        view.addSubview(newTable)
        newTable.dataSource = self
        newTable.delegate = self
    }
}



