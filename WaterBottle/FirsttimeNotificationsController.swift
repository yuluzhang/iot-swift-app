//
//  FirsttimeNotificationController.swift
//  WaterBottle
//
//  Created by Yulu Zhang on 2/25/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit
import SnapKit


class FirsttimeNotificationsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let cellId = "cellId"
    let titleArray = ["Frequency", "Target", "Reminder","Skip all settings"]
    
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
        self.tabBarController?.tabBar.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = titleArray[indexPath.row]
        let cell = newTable.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
        cell.backgroundColor = .white
        cell.textLabel?.text = name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selected row will show
        tableView.deselectRow(at: indexPath, animated: true)
        let name = titleArray[indexPath.row]
        if name == "Frequency" {
            let jump = FirsttimeFrequencyController()
            navigationController?.pushViewController(jump, animated: true)    }
        
        if name == "Target" {
            let jump = FirsttimeTargetController()
            navigationController?.pushViewController(jump, animated: true)    }
        
        if name == "Reminder" {
            let jump = FirsttimeReminderController()
            navigationController?.pushViewController(jump, animated: true)    }
        if name == "Skip all settings" {
            navigationController?.dismiss(animated: true, completion: nil)
        }
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

