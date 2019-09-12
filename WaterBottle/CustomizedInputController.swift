//
//  HistoryController.swift
//  WaterBottle
//
//  Created by 张涵雅 on 2/22/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit
import SnapKit
import Charts
import SwiftCharts

let INPUT_THEME = UIColor(hex: "d35400")

//to do for customize cup input

class CustomizedInputController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ENTER_COLOR
        self.title = "Customize Your Intake"
       homePageComponents()
        
 
        //try choices:
        //self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        let defaultTitle = "* Please Choose Your Intake:"
        let dataArr = [0.5, 1.5, 2.5, 3, 3.5, 4, 4.5, 5]
        let choices = ["0.5 cup (4 fl.oz)",
                       "1.5 cups (12 fl.oz)",
                       "2.5 cups (16 fl.oz)",
                       "3 cups (24 fl.oz)",
                       "3.5 cups (28 fl.oz) ",
                       "4 cups (32 fl.oz)",
                       "4.5 cups (36 fl.oz)",
                       "5 cups (40 fl.oz)"]
        let rect = CGRect(x: 50, y: 200, width: self.view.frame.width - 100, height: 50)
        let dropBoxView = TGDropBoxView(parentVC: self, title: defaultTitle, items: choices, frame: rect)
        dropBoxView.isHightWhenShowList = true
        dropBoxView.willShowOrHideBoxListHandler = { (isShow) in
            if isShow { NSLog("will show choices") }
            else { NSLog("will hide choices") }
        }
        dropBoxView.didShowOrHideBoxListHandler = { (isShow) in
            if isShow { NSLog("did show choices") }
            else { NSLog("did hide choices") }
        }
        dropBoxView.didSelectBoxItemHandler = { (row) in
            NSLog("selected No.\(row): \(dropBoxView.currentTitle())")
            UserDefaults.standard.set(dataArr[row],forKey: "last_consumption")
        }
        self.view.addSubview(dropBoxView)
    }
    
    
    fileprivate func homePageComponents() {
       // checkBtnComponent()
        //labelTextComponent()
        //inputTextComponent()
        //self.hideKeyboardWhenTappedAround()
        //cupTextComponent()
        confirmBtnComponents()
    }
    

    let confirmBtn: UIButton = {
        let cBtn = UIButton()
        cBtn.setImage(UIImage(named: "confirmBtn"), for: .normal)
        cBtn.addTarget(self, action: #selector(checkDistribution), for: .touchUpInside)
        return cBtn
    }()
    
    fileprivate func confirmBtnComponents() {
        view.addSubview(confirmBtn)
        confirmBtn.contentMode = .scaleAspectFit
        
        confirmBtn.snp.makeConstraints { make in
            make.height.size.equalTo(60)
            make.top.equalTo(self.view.snp.top).offset(280)
            //make.top.equalTo(labelTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.view)
        }
        confirmBtn.layer.cornerRadius = 50
    }
    

    @objc func confirmAndGoback_page() {
        UserDefaults.standard.set(true, forKey: "didLogIn")
        navigationController?.popViewController(animated: true)
        //navigationController?.pushViewController(EnterController(), animated: true)
        //self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func checkDistribution() {
        UserDefaults.standard.set(true, forKey: "didLogIn")
        //navigationController?.popViewController(animated: true)
    
        navigationController?.pushViewController(DistributionController(), animated: true)
        //navigationController?.pushViewController(EnterController(), animated: true)
        //self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    fileprivate static func getCurrentDay() -> String {
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        return String(year) + String(month) + String(day)
    }
    
    fileprivate static func getCurrentTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minute = calendar.component(.minute, from: date)
        return String(hour) + ":" + String(minute)
    }
    
    
}
