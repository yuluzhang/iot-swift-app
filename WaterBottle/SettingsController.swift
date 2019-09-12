//
//  AccountController.swift
//  WaterBottle
//
//  Created by 张涵雅 on 2/20/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit
import SnapKit


class SettingsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cellId = "cellId"
    var data = [
        ("", ["Account", "Profile", "Notifications"]),
        ("", ["Log Out"]),
    ]
    
    lazy var newTable: UITableView = {
        let table = UITableView(frame: view.frame, style: .grouped)
        return table
    }()

    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].1.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newTable.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
        cell.textLabel?.text = data[indexPath.section].1[indexPath.row]
        cell.backgroundColor = .white
        
        //try to add an arrow
        cell.accessoryType = .disclosureIndicator
        
        cell.textLabel?.text = data[indexPath.section].1[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selected row will show
        tableView.deselectRow(at: indexPath, animated: true)
        
        let name = data[indexPath.section].1[indexPath.row]
        if name == "Notifications" {
            let jump = NotificationsController()
            navigationController?.pushViewController(jump, animated: true)    }
        if name == "Log Out" {
            UserDefaults.standard.set(false, forKey: "didLogIn")
            let loginVC = LoginController()
            let navVC = UINavigationController(rootViewController: loginVC)
            self.present(navVC, animated: true, completion: nil)
//            self.tabBarController?.tabBar.isHidden = true
//            self.navigationController?.isNavigationBarHidden = true
////            self.navigationController?.navigationBar.isHidden = true
            print("Log out")

        }

        //account links to change user password
        if name == "Account" {
            let jump = ChangePasswordController()
            navigationController?.pushViewController(jump, animated: true)
        }
        //profile links to update profile
        if name == "Profile" {
            let jump = ProfileSettingsController()
            navigationController?.pushViewController(jump, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        setupNewTable()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    fileprivate func setupNewTable() {
        newTable.dataSource = self
        newTable.delegate = self
        newTable.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        view.addSubview(newTable)

        newTable.snp.makeConstraints { (table) -> Void in
            table.top.equalTo(self.view.snp.top)
            table.left.equalTo(self.view.snp.left)
            table.right.equalTo(self.view.snp.right)
            table.bottom.equalTo(self.view.snp.bottom)
        }
    }
}


