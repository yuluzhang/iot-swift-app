//
//  HomeController.swift
//  WaterBottle
//
//  Created by 张涵雅 on 2/21/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit
import SnapKit
import Charts
import SwiftCharts

let COLOR1 = UIColor(hex: "#55efc4")
let COLOR2 = UIColor(hex: "#dfe6e9")
let COLOR3 = UIColor(hex: "#74b9ff")
let COLOR4 = UIColor(hex: "#a29bfe")
let COLOR5 = UIColor(hex: "#81ecec")
let ENTER_COLOR = UIColor(hex: "E3FCFC")
let CONFIRM = UIColor(hex: "#74b9ff")
let TITLE = UIColor(hex: "#0984e3")

class EnterController: UIViewController {
    
    let titleLabel: UILabel = {
        let title = UILabel()
        let titleAttributeTitle = NSMutableAttributedString(string: "Water Intake Distribution",
                                                            attributes: [.foregroundColor: TITLE,
                                                                         .font: UIFont.systemFont(ofSize: 25)])
        title.attributedText = titleAttributeTitle
        return title
    }()
    
    lazy var titleLabelCups: UILabel = {
        let detail = UILabel()
        detail.textColor = TITLE
        let currentDayKey2 = EnterController.getCurrentDay() + ":day"
        let todayConsumption = UserDefaults.standard.double(forKey: currentDayKey2)
        detail.text = "Total: \(todayConsumption) Cups"
        return detail
    }()
    
    let enterButton: UIButton = {
        let enter = UIButton(type: .system)
        
        let enterAttributeTitle = NSMutableAttributedString(string: "Confirm 2-Cups Intake",
                                                            attributes: [.foregroundColor: UIColor.white,
                                                                         .font: UIFont.systemFont(ofSize: 22)])
        enter.setAttributedTitle(enterAttributeTitle, for: .normal)
        enter.backgroundColor = CONFIRM
        enter.layer.cornerRadius = 15
        enter.addTarget(self, action: #selector(home_page), for: .touchUpInside)
        return enter
    }()
    
    let calendarButton: UIButton = {
        let calendar = UIButton(type: .system)
        calendar.setTitle("Date", for: .normal)
        calendar.setTitleColor(.white, for: .normal)
        calendar.backgroundColor = COLOR_THEME
        calendar.layer.cornerRadius = 15
        calendar.addTarget(self, action: #selector(calendarAction), for: .touchUpInside)
        return calendar
    }()
    
    let pieChart: PieChartView = {
        let pie = PieChartView()
        pie.frame = CGRect(x: 30, y: 220, width: 310, height: 310)
        
        var dataSet = [PieChartDataEntry]()
        var colorList = [COLOR1, .white, COLOR3, COLOR4, COLOR5]
        pie.frame = CGRect(x: 30, y: 220, width: 310, height: 310)
        
        var chartDataSet = PieChartDataSet()
        var getArr = UserDefaults.standard.array(forKey: EnterController.getCurrentDay()) as? [Double]
        var getLabel = UserDefaults.standard.array(forKey: EnterController.getCurrentDay() + ":label") as? [String]
        
//        let currentDayKey = EnterController.getCurrentDay()
//        UserDefaults.standard.removeObject(forKey: currentDayKey)
        
        if getArr == nil {
            print("hhh")
        } else {
            for i in 0..<getArr!.count {
                let entry = PieChartDataEntry(value: getArr![i], label: getLabel![i])
                dataSet.append(entry)
            }
            chartDataSet = PieChartDataSet(values: dataSet, label: "Cups")
            for i in 0..<getArr!.count {
                chartDataSet.colors.append(colorList[i % colorList.count])
            }
        }
        
        chartDataSet.valueLinePart1OffsetPercentage = 1 //折线中第一段起始位置相对于扇区偏移量（值越大距越远）
        chartDataSet.valueLinePart1Length = 0.4
        chartDataSet.valueLinePart2Length = 0.2
        chartDataSet.valueLineWidth = 0.8
        chartDataSet.valueLineColor = .gray
        
        chartDataSet.xValuePosition = .outsideSlice //标签显示在外
        chartDataSet.yValuePosition = .insideSlice //数值显示在内
        
        let chartData = PieChartData(dataSet: chartDataSet)
        
        pie.data = chartData
        pie.holeColor = ENTER_COLOR
        chartData.setValueTextColor(.gray)
            
        pie.legend.enabled = false
        
        return pie
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ENTER_COLOR
        self.title = "Confirm Your Intake"
        //self.hideKeyboardWhenTappedAround()
        homePageComponents()
        
        let newFooArr: [Double] = []
        let newDayKey = EnterController.getCurrentDay()
        if UserDefaults.standard.object(forKey: newDayKey) == nil {
            UserDefaults.standard.set(newFooArr, forKey: newDayKey)
        }
        
        // label
        let newLabelArr: [String] = []
        let newDayKey1 = EnterController.getCurrentDay() + ":label"
        if UserDefaults.standard.object(forKey: newDayKey1) == nil {
            UserDefaults.standard.set(newLabelArr, forKey: newDayKey1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func calendarAction(_ sender: UIButton) {
        let calendar = CalendarController()
        navigationController?.pushViewController(calendar, animated: true)
    }
    
    fileprivate func calendarButtonComponent() {
        view.addSubview(calendarButton)
        
        calendarButton.snp.makeConstraints { (calendar) -> Void in
            calendar.size.equalTo(50)
            calendar.top.equalTo(self.view.snp.top).offset(100)
            calendar.right.equalTo(self.view.snp.right)
        }
    }
    
    fileprivate func titleLabelComponent() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(80)
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(-220)
        }
    }
    
    fileprivate func titleLabelCupsComponent() {
        view.addSubview(titleLabelCups)
        titleLabelCups.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(-180)
            make.left.equalTo(titleLabel.snp.left).offset(70)
        }
    }
    
    
    fileprivate func enterButtonComponent() {
        view.addSubview(enterButton)
        
        enterButton.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(50)
            make.left.equalTo(self.view.snp.left).offset(35)
            make.right.equalTo(self.view.snp.right).offset(-35)
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(190)
        }
    }
    
    fileprivate func pieComponent() {
        view.addSubview(pieChart)
    }
    
    fileprivate func homePageComponents() {
        pieComponent()
        titleLabelComponent()
        enterButtonComponent()
        titleLabelCupsComponent()
//        calendarButtonComponent()
    }
    
    var fooArr: [Double] = []
    var labelArr: [String] = []
    var dayArr = 0.0
    @objc func home_page() {
        let currentDayKey = EnterController.getCurrentDay()
        //UserDefaults.standard.removeObject(forKey: currentDayKey)
        print("currentday key is " + currentDayKey)
        
        if UserDefaults.standard.object(forKey: currentDayKey) != nil {
            print("1")
            fooArr = UserDefaults.standard.array(forKey: currentDayKey) as! [Double]
            fooArr.append(2.0)
//            fooArr = []
            UserDefaults.standard.set(fooArr, forKey: currentDayKey)
        } else {
            print("2")
            fooArr = []
            fooArr.append(2.0)
            UserDefaults.standard.set(fooArr, forKey: currentDayKey)
        }
        
        // label
        let currentDayKey1 = EnterController.getCurrentDay() + ":label"
        print("currentday key is " + currentDayKey1)
        
        if UserDefaults.standard.object(forKey: currentDayKey1) != nil {
            print("here1")
            labelArr = UserDefaults.standard.array(forKey: currentDayKey1) as! [String]
            labelArr.append(EnterController.getCurrentTime())
            UserDefaults.standard.set(labelArr, forKey: currentDayKey1)
        } else {
            print("here2")
            labelArr = []
            labelArr.append(EnterController.getCurrentTime())
            UserDefaults.standard.set(labelArr, forKey: currentDayKey1)
        }
        
        // Total cups for one day
        let currentDayKey2 = EnterController.getCurrentDay() + ":day"
        print("currentday key is " + currentDayKey2)
        
        if UserDefaults.standard.object(forKey: currentDayKey2) != nil {
            print("here1")
            dayArr = UserDefaults.standard.double(forKey: currentDayKey2)
            
            dayArr = dayArr + 2.0
            UserDefaults.standard.set(dayArr, forKey: currentDayKey2)
        } else {
            print("here2")
            dayArr = 0.0
            dayArr = dayArr + 2.0
            UserDefaults.standard.set(dayArr, forKey: currentDayKey2)
        }
        
        UserDefaults.standard.set(2, forKey: "last_consumption")
        navigationController?.popViewController(animated: true)
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
//        var hour = calendar.component(.hour, from: date)
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





