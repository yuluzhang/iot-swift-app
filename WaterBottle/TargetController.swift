//
//  TargetController.swift
//  WaterBottle
//
//  Created by 张涵雅 on 2/21/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit
import SnapKit


class TargetController: UIViewController {
    
    let cellId = "cellId"
    let titleArray = ["12 pm", "3 pm", "6 pm", "9 pm", "No need"]
    
    lazy var newTable: UITableView = {
        let table = UITableView(frame: self.view.frame, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Target"
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
        
        newTable.snp.makeConstraints { (table) -> Void in
            table.top.equalTo(self.view.snp.top)
            table.left.equalTo(self.view.snp.left)
            table.right.equalTo(self.view.snp.right)
            table.bottom.equalTo(self.view.snp.bottom)
        }
    }
}




