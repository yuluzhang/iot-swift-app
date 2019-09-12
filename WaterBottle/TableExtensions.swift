//
//  TableExtensions.swift
//  WaterBottle
//
//  Created by 张涵雅 on 2/21/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import Foundation
import UIKit


//extension SettingsController: UITableViewDataSource, UITableViewDelegate {
//
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return data.count
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data[section].1.count
//    }
//
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return data[section].0
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        if indexPath.section == 0 {
////            let name = titleArray[indexPath.row]
////            let cell = newTable.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
////            cell.backgroundColor = .white
////            cell.textLabel?.text = name
////            return cell
////        } else {
////            let cell = newTable.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
////            cell.backgroundColor = .white
////            cell.textLabel?.text = "Log Out"
////            return cell
////        }
//        let cell = newTable.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
//        cell.textLabel?.text = data[indexPath.section].1[indexPath.row]
//        cell.backgroundColor = .white
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        if indexPath.section == 0 {
////            let name = titleArray[indexPath.row]
////            if name == "Notifications" {
////                let jump = NotificationsController()
////                navigationController?.pushViewController(jump, animated: true)    }
////
//////            if name == "Account" {
//////                let jump = NotificationsController()
//////                navigationController?.pushViewController(jump, animated: true)    }
//////
//////            if name == "Profile" {
//////                let jump = NotificationsController()
//////                navigationController?.pushViewController(jump, animated: true)    }
////        } else {
////            let jump = LoginController()
////            navigationController?.pushViewController(jump, animated: false)
////        }
//        let name = data[indexPath.section].1[indexPath.row]
//        if name == "Notifications" {
//            let jump = NotificationsController()
//            navigationController?.pushViewController(jump, animated: true)    }
//
//        //            if name == "Account" {
//        //                let jump = NotificationsController()
//        //                navigationController?.pushViewController(jump, animated: true)    }
//        //
//        //            if name == "Profile" {
//        //                let jump = NotificationsController()
//        //                navigationController?.pushViewController(jump, animated: true)    }
//    }
//}

extension NotificationsController: UITableViewDataSource, UITableViewDelegate {    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = titleArray[indexPath.row]
        let cell = newTable.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
        cell.backgroundColor = .white
        cell.textLabel?.text = name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //selected row will show
        tableView.deselectRow(at: indexPath, animated: true)
        
        let name = titleArray[indexPath.row]
        if name == "Frequency" {
            let jump = FrequencyController()
            navigationController?.pushViewController(jump, animated: true)    }
        
        if name == "Target" {
            let jump = TargetController()
            navigationController?.pushViewController(jump, animated: true)    }
        
        if name == "Reminder" {
            let jump = ReminderController()
            navigationController?.pushViewController(jump, animated: true)    }
    }
}

extension FrequencyController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = titleArray[indexPath.row]
        
        let cell = FreqSelectionCell(name: name)
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCell = tableView.cellForRow(at: indexPath) as! FreqSelectionCell
        selectedCell.showCheckMark()
        let timeArray = [120, 180, 240, 300, 0]

        UserDefaults.standard.set(timeArray[indexPath.item],forKey: "frequency")
        //print("timeArray[indexPath.item: " + String(timeArray[indexPath.item]))

        for cell in tableView.visibleCells {
            guard let fooCell = cell as? FreqSelectionCell else {
                break
            }
            if (fooCell != selectedCell) {
                fooCell.removeCheckMark()
            }
        }
    
        
    }
}

extension ReminderController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = titleArray[indexPath.row]
//        let cell = newTable.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
//        cell.backgroundColor = .white
//        cell.textLabel?.text = name
        
        let cell = FreqSelectionCell(name: name)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCell = tableView.cellForRow(at: indexPath) as! FreqSelectionCell
        selectedCell.showCheckMark()
        let timeArray = [60, 120, 180, 240, 0]
        
        UserDefaults.standard.set(timeArray[indexPath.item],forKey: "reminder")
        
        for cell in tableView.visibleCells {
            guard let fooCell = cell as? FreqSelectionCell else {
                break
            }
            if (fooCell != selectedCell) {
                fooCell.removeCheckMark()
            }
        }
        
        //navigationController?.popViewController(animated: true)
    }
}

extension TargetController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let name = titleArray[indexPath.row]
//        let cell = newTable.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as UITableViewCell
//        cell.backgroundColor = .white
//        cell.textLabel?.text = name
        let cell = FreqSelectionCell(name: name)
        //read previous setup mark and show it
        //cell.showCheckMark()

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCell = tableView.cellForRow(at: indexPath) as! FreqSelectionCell
        selectedCell.showCheckMark()
        
        let timeArray = [12 * 60, 15 * 60, 18 * 60, 21 * 60, 0]
        
        UserDefaults.standard.set(timeArray[indexPath.item],forKey: "targetsettings")
        
        for cell in tableView.visibleCells {
            guard let fooCell = cell as? FreqSelectionCell else {
                break
            }
            if (fooCell != selectedCell) {
                fooCell.removeCheckMark()
            }
        }
        
        //navigationController?.popViewController(animated: true)
    }
}
