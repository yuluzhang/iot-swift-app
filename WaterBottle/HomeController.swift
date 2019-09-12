//
//  HomeController.swift
//  WaterBottle
//
//  Created by 张涵雅 on 2/24/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit
import SnapKit
import Charts
import SwiftCharts
import Alamofire


class HomeController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "Dripdrop"
        calendarButtonComponent()
        imageComponent()
        hydrationStatusComponent()
        targetComponent()
        customizeBtnComponents()
        customizeTextComponent()
        oneCupBtnComponents()
        oneCupTextComponent()
        twoCupBtnComponents()
        twoCupTextComponent()
        lastTimeIntakeComponent()
        helloComponent()
        
        // If user is not logged in
        if (!UserDefaults.standard.bool(forKey: "didLogIn")) {
            let loginVC = LoginController()
            let navVC = UINavigationController(rootViewController: loginVC)
            self.present(navVC, animated: true, completion: nil)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        let lastConsumption = UserDefaults.standard.double(forKey: "last_consumption")
        
        let date = Date()
        let calendar = Calendar.current
        let month = numToMonth(calendar.component(.month, from: date))
        let day = calendar.component(.day, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let curHourMinute = String(hour) + ":" + String(minutes)
        
        let lastAttributeTitle = NSMutableAttributedString(string: "\(lastConsumption)  Cups at \(curHourMinute) on \(month), \(day)",
            attributes: [.foregroundColor: COLOR_THEME_DEEP,
                         .font: UIFont.systemFont(ofSize: 16)])
        lastIntakeLabel.attributedText = lastAttributeTitle

        UserDefaults.standard.set(hour * 60 + minutes, forKey: "lastConsumeTime")
        
        let currentDayKey2 = HomeController.getCurrentDay() + ":day"
        let todayConsumption = UserDefaults.standard.double(forKey: currentDayKey2)
        let targetforToday = UserDefaults.standard.double(forKey: "target")
        let consumptionRate = Double(todayConsumption) / targetforToday
        let hourRate = Double(hour*60 + minutes)/1440
        
        print("hourRate is ", hourRate)
        print("consumptionRate is ", consumptionRate)
        
        //judge if today <  the target poor
        let hydrationStatusTitle = NSMutableAttributedString(string: "Status: ", attributes: [.foregroundColor: COLOR_THEME_DEEP,.font: UIFont.systemFont(ofSize: 16)])
        
        if(consumptionRate < 0.8 * hourRate) {
            hydrationStatusTitle.append(NSAttributedString(string: "*Poor*", attributes: [.foregroundColor: UIColor.orange,
                                                                                          .font: UIFont.systemFont(ofSize: 24)]))
        } else if(consumptionRate >= 0.8 * hourRate && consumptionRate <= 1.2 * hourRate ){
            hydrationStatusTitle.append(NSAttributedString(string: "*Good*", attributes: [.foregroundColor: COLOR_GOOD,
                                                                                          .font: UIFont.systemFont(ofSize: 24)]))
        } else if (consumptionRate > 1.2 * hourRate && consumptionRate <= 2.0 * hourRate ){
            hydrationStatusTitle.append(NSAttributedString(string: "*Excellent*", attributes: [.foregroundColor: COLOR_EXCELLENT,
                                                                                            .font: UIFont.systemFont(ofSize: 24)]))
        } else if (consumptionRate > 2.0 * hourRate){
            hydrationStatusTitle.append(NSAttributedString(string: "*Too Much*", attributes: [.foregroundColor: COLOR_TOOMUCH,
                                                                                               .font: UIFont.systemFont(ofSize: 24)]))
        }
        
        hydrationStatusTitle.append(NSAttributedString(string: "(Total: \(todayConsumption) cups)", attributes: [.foregroundColor: COLOR_THEME_DEEP,
                                                                        .font: UIFont.systemFont(ofSize: 16)]))
        
        hydrationStatusLabel.attributedText = hydrationStatusTitle
        
        let targetAttributeTitle = NSAttributedString(string: "Today's Target: \(targetforToday) cups ", attributes: [.foregroundColor: COLOR_THEME_DEEP,.font: UIFont.systemFont(ofSize: 16)])
        targetTextLabel.attributedText =  targetAttributeTitle
        
        progressView.progress = Float(consumptionRate)
        
        navigationController?.isNavigationBarHidden = false
        // No settings
    }
    
    fileprivate func numToMonth(_ month: Int) -> String {
        switch month {
        case 1:
            return "Jan"
        case 2:
            return "Feb"
        case 3:
            return "Mar"
        case 4:
            return "Apr"
        case 5:
            return "May"
        case 6:
            return "Jun"
        case 7:
            return "Jul"
        case 8:
            return "Aug"
        case 9:
            return "Sep"
        case 10:
            return "Oct"
        case 11:
            return "Nov"
        case 12:
            return "Dec"
        default:
            return ""
        }
    }
    
    //calendar button
    let calendarBtn: UIButton = {
        let calendar = UIButton()
        calendar.setImage(UIImage(named: "calendar"), for: .normal)
        //calendar.setTitle("Check My Past Daily Intake Calendar", for: .normal)
        //calendar.setTitleColor(.white, for: .normal)
        //calendar.backgroundColor = .white
        calendar.layer.cornerRadius = 15
        calendar.addTarget(self, action: #selector(calendarAction), for: .touchUpInside)
        return calendar
    }()
    
    @objc func calendarAction(_ sender: UIButton) {
        let calendar = CalendarController()
        navigationController?.pushViewController(calendar, animated: true)
    }
    
    
    fileprivate func calendarButtonComponent() {
        view.addSubview(calendarBtn)
        calendarBtn.clipsToBounds = true
        calendarBtn.imageView?.contentMode = .scaleAspectFit
        calendarBtn.contentMode = .scaleAspectFit
        

        calendarBtn.snp.makeConstraints { calendar in
            calendar.size.equalTo(60)
            calendar.top.equalTo(self.view.snp.top).offset(100)
            calendar.right.equalTo(self.view.snp.right).offset(-10)
        }
    }
    
    let helloTextField: UITextField =  {
        let hello = UITextField()
        let helloAttributePlaceholder = NSAttributedString(string: "Hello ", attributes: [.foregroundColor: COLOR_THEME_DEEP,.font: UIFont.systemFont(ofSize: 24)])
        
        hello.attributedPlaceholder = helloAttributePlaceholder
        hello.backgroundColor = .white
        hello.textColor = .white
        hello.isSecureTextEntry = false
        hello.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        hello.layer.shadowOpacity = 1
        hello.layer.shadowRadius = 0
        hello.layer.shadowColor = UIColor.white.cgColor
        return hello
    } ()
    
    fileprivate func helloComponent() {
        view.addSubview(helloTextField)
        
        helloTextField.snp.makeConstraints { (hello) -> Void in
            hello.top.equalTo(self.view.snp.top).offset(120)
            //hello.top.equalTo(self.view.snp.top).offset(-25)
            hello.left.equalTo(self.view.snp.left).offset(10)
            //hello.centerX.equalTo(self.view)
        }
    }
    
    let targetTextLabel:UILabel = {
        let target = UILabel()
        
        let targetforToday = UserDefaults.standard.double(forKey: "target")
        let targetAttributeTitle = NSAttributedString(string: "Today's Target: \(targetforToday) cups ", attributes: [.foregroundColor: COLOR_THEME_DEEP,.font: UIFont.systemFont(ofSize: 16)])
        target.attributedText = targetAttributeTitle
        return target
    }()
    
    
    fileprivate func targetComponent() {
        view.addSubview(targetTextLabel)
        
        targetTextLabel.snp.makeConstraints { (target) -> Void in
            target.top.equalTo(hydrationStatusLabel.snp.bottom).offset(3)
            target.centerX.equalTo(progressView)
        }
    }
    
    
    private let progressView : UIProgressView = {
        let prgressView = UIProgressView()
        let currentDayKey2 = HomeController.getCurrentDay() + ":day"
        let todayConsumption = UserDefaults.standard.double(forKey: currentDayKey2)
        let targetforToday = UserDefaults.standard.double(forKey: "target")

        let prog = Double(todayConsumption) / targetforToday
        prgressView.progress = Float(prog)
        prgressView.progressTintColor = COLOR_DRUNK
        prgressView.trackTintColor = COLOR_TINT
        prgressView.layer.cornerRadius = 6.5
        prgressView.clipsToBounds = true
        prgressView.transform = CGAffineTransform(rotationAngle: .pi / -2)
        prgressView.translatesAutoresizingMaskIntoConstraints = false
        return prgressView
    }()
    
    fileprivate func imageComponent() {
        view.addSubview(progressView)
        progressView.widthAnchor.constraint(equalToConstant: 270).isActive = true
        progressView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    
    //below principle image
    let lastTimeIntakeTextField: UITextField =  {
        let last = UITextField()
        let lastAttributePlaceholder = NSAttributedString(string: "Last Consumption:", attributes: [.foregroundColor: COLOR_THEME_DEEP,.font: UIFont.systemFont(ofSize: 16)])
  
        last.attributedPlaceholder = lastAttributePlaceholder
        last.backgroundColor = .white
        last.textColor = .white
        last.isSecureTextEntry = false
        last.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        last.layer.shadowOpacity = 1
        last.layer.shadowRadius = 0
        last.layer.shadowColor = UIColor.white.cgColor
        return last
    } ()
    
    let lastIntakeLabel:UILabel = {
        let lastIntake = UILabel()
        let lastConsumption = UserDefaults.standard.double(forKey: "last_consumption")
        
        let lastAttributeTitle = NSMutableAttributedString(string: "\(lastConsumption)  Cups at 8:00 pm",
                                                            attributes: [.foregroundColor: COLOR_THEME_DEEP,
                                                                         .font: UIFont.systemFont(ofSize: 20)])
        lastIntake.attributedText = lastAttributeTitle
        return lastIntake
    }()

    
    fileprivate func lastTimeIntakeComponent() {
        view.addSubview(lastTimeIntakeTextField)
        view.addSubview(lastIntakeLabel)
        
        lastTimeIntakeTextField.snp.makeConstraints { (last) -> Void in
            //target.height.size.equalTo(30)
            last.top.equalTo(progressView.snp.bottom).offset(120)
            last.centerX.equalTo(progressView)
        }
        lastIntakeLabel.snp.makeConstraints { (last) -> Void in
            //target.height.size.equalTo(30)
            last.top.equalTo(lastTimeIntakeTextField.snp.bottom)
            //target.left.equalTo(self.view.snp.left).offset(90)
            last.centerX.equalTo(progressView)
        }
    }
    
    
    let hydrationStatusLabel:UILabel = {
        let target = UILabel()
        let currentDayKey2 = HomeController.getCurrentDay() + ":day"
        let todayConsumption = UserDefaults.standard.double(forKey: "currentDayKey2")
        let targetforToday = UserDefaults.standard.double(forKey: "target")
        let consumptionRate = Double(todayConsumption / targetforToday)
        
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let hourRate = Double(hour)/24.0
        
        
        //judge if today <  the target poor
        let hydrationStatusTitle = NSMutableAttributedString(string: "Your hydration status: ", attributes: [.foregroundColor: COLOR_THEME_DEEP,.font: UIFont.systemFont(ofSize: 16)])
        
        if(consumptionRate < 0.8 * hourRate) {
            hydrationStatusTitle.append(NSAttributedString(string: "*Poor*", attributes: [.foregroundColor: UIColor.orange,
                                                                                          .font: UIFont.systemFont(ofSize: 24)]))
        } else if(consumptionRate >= 0.8 * hourRate && consumptionRate <= 1.2 * hourRate ){
            hydrationStatusTitle.append(NSAttributedString(string: "*Good*", attributes: [.foregroundColor: UIColor.orange,
                                                                                          .font: UIFont.systemFont(ofSize: 24)]))
        } else if (consumptionRate > 1.2 * hourRate && consumptionRate <= 1.6 * hourRate ){
            hydrationStatusTitle.append(NSAttributedString(string: "*Excellent*", attributes: [.foregroundColor: UIColor.orange,
                                                                                               .font: UIFont.systemFont(ofSize: 24)]))
        } else {
            hydrationStatusTitle.append(NSAttributedString(string: "*Too Much*", attributes: [.foregroundColor: UIColor.orange,
                                                                                              .font: UIFont.systemFont(ofSize: 24)]))
        }
        
        
        target.attributedText = hydrationStatusTitle
        return target
    }()
    
    
    fileprivate func hydrationStatusComponent() {
        view.addSubview(hydrationStatusLabel)
        
        hydrationStatusLabel.snp.makeConstraints { (hydration) -> Void in
            hydration.height.size.equalTo(50)
            hydration.top.equalTo(self.view.snp.top).offset(150)
            hydration.left.equalTo(self.view.snp.left).offset(5)
            hydration.right.equalTo(self.view.snp.right).offset(-35)
        }
    }
    
    //customize cup image:
    let customizeBtn: UIButton = {
        let cBtn = UIButton()
        let fooImg = UIImage(named: "customize-cup")
        let resizedImg = UIImage.resizedImage(image: fooImg!, scaledToSize: CGSize(width: 50, height: 50))
        cBtn.setImage(resizedImg, for: .normal)
        
        //cBtn.setImage(UIImage(named: "customize-cup"), for: .normal)
        cBtn.addTarget(self, action: #selector(customizeControl_page), for: .touchUpInside)
        return cBtn
    }()
    
    fileprivate func customizeBtnComponents() {
        view.addSubview(customizeBtn)
        customizeBtn.contentMode = .scaleAspectFit
        customizeBtn.snp.makeConstraints { make in
            make.height.size.equalTo(80)
            make.top.equalTo(self.view.snp.top).offset(610)
            make.left.equalTo(self.view.snp.left).offset(250)
        }
        customizeBtn.layer.cornerRadius = 30
    }

    
    let customizeTextField: UITextField =  {
        let customize = UITextField()
        let customizeAttributePlaceholder = NSAttributedString(string: "Customize", attributes: [.foregroundColor: COLOR_THEME_DEEP,.font: UIFont.systemFont(ofSize: 16)])
        
        
        customize.attributedPlaceholder = customizeAttributePlaceholder
        customize.backgroundColor = .white
        customize.textColor = .white
        customize.isSecureTextEntry = false
        customize.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        customize.layer.shadowOpacity = 1
        customize.layer.shadowRadius = 0
        customize.layer.shadowColor = UIColor.white.cgColor
        return customize
    } ()
    
    fileprivate func customizeTextComponent() {
        view.addSubview(customizeTextField)
        
        customizeTextField.snp.makeConstraints { (target) -> Void in
            target.bottom.equalTo(customizeBtn.snp.top)
            target.centerX.equalTo(customizeBtn)
        }
    }
    
    //input 1 cup image:
    let oneCupBtn: UIButton = {
        let cBtn = UIButton()
        let fooImg = UIImage(named: "onecup")
        let resizedImg = UIImage.resizedImage(image: fooImg!, scaledToSize: CGSize(width: 50, height: 50))
        cBtn.setImage(resizedImg, for: .normal)
        //cBtn.setImage(UIImage(named: "small-cup"), for: .normal)
        cBtn.addTarget(self, action: #selector(oneCupControl_page), for: .touchUpInside)
        return cBtn
    }()
    
    fileprivate func oneCupBtnComponents() {
        view.addSubview(oneCupBtn)
        oneCupBtn.contentMode = .scaleAspectFit
        oneCupBtn.snp.makeConstraints { make in
            make.height.size.equalTo(100)
            make.top.equalTo(self.view.snp.top).offset(590)
            make.left.equalTo(self.view.snp.left).offset(30)
        }
        oneCupBtn.layer.cornerRadius = 30
    }

    
    let oneCupTextField: UITextField =  {
        let onecup = UITextField()
        let onecupAttributePlaceholder = NSAttributedString(string: "8 fl.oz (1 cup)", attributes: [.foregroundColor: COLOR_THEME_DEEP,.font: UIFont.systemFont(ofSize: 16)])
        
        
        onecup.attributedPlaceholder = onecupAttributePlaceholder
        onecup.backgroundColor = .white
        onecup.textColor = .white
        onecup.isSecureTextEntry = false
        onecup.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        onecup.layer.shadowOpacity = 1
        onecup.layer.shadowRadius = 0
        onecup.layer.shadowColor = UIColor.white.cgColor
        return onecup
    } ()
    
    fileprivate func oneCupTextComponent() {
        view.addSubview(oneCupTextField)
        
        oneCupTextField.snp.makeConstraints { (target) -> Void in
            //target.height.size.equalTo(30)
            target.top.equalTo(oneCupBtn.snp.top)
            //target.left.equalTo(self.view.snp.left).offset(90)
            target.centerX.equalTo(oneCupBtn)
        }
    }
    
    //input 2 cups image:
    let twoCupBtn: UIButton = {
        let cBtn = UIButton()
        let fooImg = UIImage(named: "twocup")
        let resizedImg = UIImage.resizedImage(image: fooImg!, scaledToSize: CGSize(width: 50, height: 50))
        cBtn.setImage(resizedImg, for: .normal)
        cBtn.addTarget(self, action: #selector(twoCupControl_page), for: .touchUpInside)
        return cBtn
    }()
    
    fileprivate func twoCupBtnComponents() {
        view.addSubview(twoCupBtn)
        twoCupBtn.contentMode = .scaleAspectFit
        twoCupBtn.snp.makeConstraints { make in
            make.height.size.equalTo(120)
            
            make.top.equalTo(oneCupBtn.snp.top)
            make.left.equalTo(oneCupBtn.snp.left).offset(90)
        }
        twoCupBtn.layer.cornerRadius = 30
    }
    
    
    let towCupTextField: UITextField =  {
        let twocup = UITextField()
        let twocupAttributePlaceholder = NSAttributedString(string: "2 cups", attributes: [.foregroundColor: COLOR_THEME_DEEP,.font: UIFont.systemFont(ofSize: 16)])
        
        
        twocup.attributedPlaceholder = twocupAttributePlaceholder
        twocup.backgroundColor = .white
        twocup.textColor = .white
        twocup.isSecureTextEntry = false
        twocup.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        twocup.layer.shadowOpacity = 1
        twocup.layer.shadowRadius = 0
        twocup.layer.shadowColor = UIColor.white.cgColor
        return twocup
    } ()
    
    fileprivate func twoCupTextComponent() {
        view.addSubview(towCupTextField)
        
        towCupTextField.snp.makeConstraints { (target) -> Void in
            //target.height.size.equalTo(30)
            target.top.equalTo(twoCupBtn.snp.top)
            //target.left.equalTo(self.view.snp.left).offset(90)
            target.centerX.equalTo(twoCupBtn)
        }
    }
    
    
    
    @objc func twoCupControl_page() {
        UserDefaults.standard.set(true, forKey: "didLogIn")
        navigationController?.pushViewController(EnterController(), animated: true)
        //self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func oneCupControl_page() {
        UserDefaults.standard.set(true, forKey: "didLogIn")
        navigationController?.pushViewController(EnterOneCupConfirmController(), animated: true)
        //self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    //
    @objc func customizeControl_page() {
        UserDefaults.standard.set(true, forKey: "didLogIn")
        navigationController?.pushViewController(CustomizedInputController(), animated: true)
        //self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    fileprivate static func getCurrentDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: Date())
    }
    
}
