//
//  DailyIntakeGraphController.swift
//  WaterBottle
//
//  Created by Yulu Zhang on 2/26/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit
import SnapKit
import Charts
import SwiftCharts

class DailyIntakeGraphController: UIViewController{
    let titleLabel: UILabel = {
        let title = UILabel()
        let titleAttributeTitle = NSMutableAttributedString(string: "Water Intake Distribution",
                                                            attributes: [.foregroundColor: TITLE,
                                                                         .font: UIFont.systemFont(ofSize: 25)])
        title.attributedText = titleAttributeTitle
        return title
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
        let entry1 = PieChartDataEntry(value: 1, label: "10 AM")
        let entry2 = PieChartDataEntry(value: 1, label: "Left")
        let entry3 = PieChartDataEntry(value: 3, label: "8 PM")
        let entry4 = PieChartDataEntry(value: 2, label: "3 PM")
        let entry5 = PieChartDataEntry(value: 2, label: "12 PM")
        dataSet.append(entry1)
        dataSet.append(entry2)
        dataSet.append(entry3)
        dataSet.append(entry4)
        dataSet.append(entry5)
        
        let chartDataSet = PieChartDataSet(values: dataSet, label: "Cups")
        
        chartDataSet.colors = [COLOR1, .white, COLOR3, COLOR4, COLOR5]
        
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
            make.centerY.equalTo(self.view.snp.centerY).offset(-300)
        }
    }

    fileprivate func pieComponent() {
        view.addSubview(pieChart)
    }
    
    fileprivate func homePageComponents() {
        pieComponent()
        titleLabelComponent()
        //        calendarButtonComponent()
    }
    
    
}


