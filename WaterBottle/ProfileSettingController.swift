//
//  ProfileSettingController.swift
//  WaterBottle
//
//  Created by Yulu Zhang on 2/25/19.
//  Updated by Luyao Li on 2/27/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit

class ProfileSettingsController: UIViewController {
    
    lazy var weightLabel: UILabel = {
        let title = UILabel()
        title.textColor = COLOR_THEME_DEEP
        title.shadowColor = COLOR_THEME
        return title
    }()
    
    lazy var genderLabel: UILabel = {
        let title = UILabel()
        title.textColor = COLOR_THEME_DEEP
        title.shadowColor = COLOR_THEME
        return title
    }()
    
    lazy var workoutLabel: UILabel = {
        let title = UILabel()
        title.textColor = COLOR_THEME_DEEP
        title.shadowColor = COLOR_THEME
        return title
    }()
    
    lazy var targetLabel: UILabel = {
        let title = UILabel()
        title.textColor = COLOR_THEME_DEEP
        title.shadowColor = COLOR_THEME
        return title
    }()
    
    let commentButton: UIButton = {
        let comment = UIButton(type: .system)
        comment.setTitle("Recommended by DripDrop", for: .normal)
        comment.setTitleColor(.white, for: .normal)
        comment.backgroundColor = COLOR_THEME
        //comment.addTarget(self, action: #selector(forgetPassword), for: .touchUpInside)
        return comment
    }()
    
    let intakeButton: UIButton = {
        let intake = UIButton(type: .system)
        intake.setTitle("0.0 Cups", for: .normal)
        let curweight = UserDefaults.standard.double(forKey: "weight")
        let workout = UserDefaults.standard.double(forKey: "work_out_perday")

        let target = Int((curweight * 2 / 3 + workout * 12)/8)
        UserDefaults.standard.set(target,forKey: "target")

        let currentDayKey = ProfileSettingsController.getCurrentDay() + "target"
        UserDefaults.standard.set(target,forKey: currentDayKey)
        
        
        intake.setTitle("\(target) Cups", for: .normal)
        intake.setTitleColor(.white, for: .normal)
        intake.backgroundColor = COLOR_THEME
        //comment.addTarget(self, action: #selector(forgetPassword), for: .touchUpInside)
        return intake
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ENTER_COLOR
        self.title = "Profile"

        homePageComponents()
        
        //try choices:
        //self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        // Body Weight Label
        weightLabel.text = "Body Weight"
        let defaultTitle = "Choose Weight Range"
        let weightArr = [90, 100, 130, 150, 170, 190, 210, 230]
        
        let choices = ["80-100 (lbs)",
                       "100-120 (lbs)",
                       "120-140 (lbs)",
                       "140-160 (lbs)",
                       "160-180 (lbs)",
                       "180-200 (lbs)",
                       "200-220 (lbs)",
                       "More than 220 lbs"]
        let rect = CGRect(x: 180, y: 100, width: self.view.frame.width - 200, height: 50)
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
            UserDefaults.standard.set(weightArr[row],forKey: "weight")
        }
        self.view.addSubview(dropBoxView)
        
        // Gender Label
        genderLabel.text = "Bio Gender"
        let defaultTitle_2 = "Choose Gender"
        let choices_2 = ["Male",
                       "Female"]
        let rect_2 = CGRect(x: 180, y: 160, width: self.view.frame.width - 200, height: 50)
        let dropBoxView_2 = TGDropBoxView(parentVC: self, title: defaultTitle_2, items: choices_2, frame: rect_2)
        dropBoxView_2.isHightWhenShowList = true
        dropBoxView_2.willShowOrHideBoxListHandler = { (isShow) in
            if isShow { NSLog("will show choices") }
            else { NSLog("will hide choices") }
        }
        dropBoxView_2.didShowOrHideBoxListHandler = { (isShow) in
            if isShow { NSLog("did show choices") }
            else { NSLog("did hide choices") }
        }
        dropBoxView_2.didSelectBoxItemHandler = { (row) in
            NSLog("selected No.\(row): \(dropBoxView.currentTitle())")
        }
        self.view.addSubview(dropBoxView_2)
        
        // Workout Label
        workoutLabel.text = "AVG Workout hr/day"
        let defaultTitle_3 = "Choose Hour"
        let workArr = [1, 2, 3, 4, 5, 6, 7]

        let choices_3 = ["30 min",
                         "60 min",
                         "90 min",
                         "120 min",
                         "150 min",
                         "180 min",
                         "More than 180 min"]
        let rect_3 = CGRect(x: 220, y: 220, width: self.view.frame.width - 240, height: 50)
        let dropBoxView_3 = TGDropBoxView(parentVC: self, title: defaultTitle_3, items: choices_3, frame: rect_3)
        dropBoxView_3.isHightWhenShowList = true
        dropBoxView_3.willShowOrHideBoxListHandler = { (isShow) in
            if isShow { NSLog("will show choices") }
            else { NSLog("will hide choices") }
        }
        dropBoxView_3.didShowOrHideBoxListHandler = { (isShow) in
            if isShow { NSLog("did show choices") }
            else { NSLog("did hide choices") }
        }
        dropBoxView_3.didSelectBoxItemHandler = { (row) in
            NSLog("selected No.\(row): \(dropBoxView.currentTitle())")
            UserDefaults.standard.set(workArr[row],forKey: "work_out_perday")
        }
        self.view.addSubview(dropBoxView_3)
        
        // Target Label
        targetLabel.text = "Target Daily Water Intake"
        
        
        
    }
    
    fileprivate func weightComponent() {
        view.addSubview(weightLabel)
        
        weightLabel.snp.makeConstraints{ (weight) -> Void in
            weight.height.equalTo(50)
            weight.top.equalTo(self.view.snp.top).offset(100)
            weight.left.equalTo(self.view.snp.left).offset(20)
            weight.right.equalTo(self.view.snp.right).offset(-35)
        }
    }
    
    fileprivate func genderComponent() {
        view.addSubview(genderLabel)
        
        genderLabel.snp.makeConstraints{ (gender) -> Void in
            gender.height.equalTo(50)
            gender.top.equalTo(self.view.snp.top).offset(160)
            gender.left.equalTo(self.view.snp.left).offset(20)
            gender.right.equalTo(self.view.snp.right).offset(-35)
        }
    }
    
    fileprivate func workoutComponent() {
        view.addSubview(workoutLabel)
        
        workoutLabel.snp.makeConstraints{ (workout) -> Void in
            workout.height.equalTo(50)
            workout.top.equalTo(self.view.snp.top).offset(220)
            workout.left.equalTo(self.view.snp.left).offset(20)
            workout.right.equalTo(self.view.snp.right).offset(-35)
        }
    }
    
    fileprivate func targetComponent() {
        view.addSubview(targetLabel)
        
        targetLabel.snp.makeConstraints{ (workout) -> Void in
            workout.height.equalTo(50)
            workout.top.equalTo(self.view.snp.top).offset(310)
            workout.left.equalTo(self.view.snp.left).offset(20)
            workout.right.equalTo(self.view.snp.right).offset(-35)
        }
        
        view.addSubview(intakeButton)
        
        intakeButton.snp.makeConstraints { (intake) -> Void in
            intake.height.equalTo(50)
            intake.top.equalTo(self.view.snp.top).offset(310)
            intake.left.equalTo(self.view.snp.left).offset(240)
            intake.right.equalTo(self.view.snp.right).offset(-30)
        }
        /*  // Comment below the target water intake
        view.addSubview(commentButton)
        
        commentButton.snp.makeConstraints { (comment) -> Void in
            comment.height.equalTo(30)
            comment.top.equalTo(self.view.snp.top).offset(340)
            comment.left.equalTo(self.view.snp.left).offset(120)
            comment.right.equalTo(self.view.snp.right).offset(-70)
        }*/
    }
    
    fileprivate func homePageComponents() {
        weightComponent()
        genderComponent()
        workoutComponent()
        targetComponent()
        confirmBtnComponents()
    }
    
    
    let confirmBtn: UIButton = {
        let cBtn = UIButton()
        cBtn.setImage(UIImage(named: "confirmBtn"), for: .normal)
        cBtn.addTarget(self, action: #selector(confirmProfile), for: .touchUpInside)
        return cBtn
    }()
    
    fileprivate func confirmBtnComponents() {
        view.addSubview(confirmBtn)
        confirmBtn.contentMode = .scaleAspectFit
        
        confirmBtn.snp.makeConstraints { make in
            make.height.size.equalTo(60)
            make.top.equalTo(self.view.snp.top).offset(400)
            //make.top.equalTo(labelTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.view)
        }
        confirmBtn.layer.cornerRadius = 50
    }
    
    
    @objc func confirmProfile() {
//        let currentDayKey = ProfileSettingsController.getCurrentDay() + "target"
//        UserDefaults.standard.set(target,forKey: currentDayKey)
        navigationController?.popViewController(animated: true)
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
        
        navigationController?.pushViewController(HomeController(), animated: true)
        //navigationController?.pushViewController(EnterController(), animated: true)
        //self.navigationController?.dismiss(animated: true, completion: nil)
    }

    fileprivate static func getCurrentDay() -> String {
        //        let date = Date()
        //        let calendar = Calendar.current
        //        let year = calendar.component(.year, from: date)
        //        let month = calendar.component(.month, from: date)
        //        let day = calendar.component(.day, from: date)
        //        return String(year) + String(month) + String(day)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: Date())
    }
    
    fileprivate static func getCurrentTime() -> String {
        //        let date = Date()
        //        let calendar = Calendar.current
        //        let hour = calendar.component(.hour, from: date)
        //        let minutes = calendar.component(.minute, from: date)
        //        return String(hour) + ":" + String(minutes)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: Date())
        
        //        if (hour > 12) {
        //            hour = hour - 12
        //            return String(hour) + ":" + String(minutes) + " PM"
        //        } else {
        //            return String(hour) + ":" + String(minutes) + " AM"
        //        }
    }
}
