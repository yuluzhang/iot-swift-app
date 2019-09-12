//
//  ReportController.swift
//  WaterBottle
//
//  Created by 张涵雅 on 2/24/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit
import SnapKit
import Charts
import Foundation

let HISTORY_COLOR = UIColor(hex: "E3FCFC")

class HistoryController: UIViewController {
    
    fileprivate func generateDayData() -> BarChartData {
        var dataEntriesDay = [BarChartDataEntry]()
        var getArr = UserDefaults.standard.array(forKey: HistoryController.getCurrentDay()) as? [Double]
        var getLabel = UserDefaults.standard.array(forKey: HistoryController.getCurrentDay() + ":label") as? [String]
        if getArr == nil {
            for i in 0..<24 {
                let value = Double(0.0)
                let entry = BarChartDataEntry(x: Double(i), yValues: [value])
                dataEntriesDay.append(entry)
            }
        } else {
            var dailyRecord = Array(repeating: 0.0, count: 24)
            for i in 0..<getLabel!.count {
                let hour = Int(getLabel![i].split(separator: ":")[0])
                dailyRecord[hour!] = dailyRecord[hour!] + getArr![i]
            }
            
            for i in 0..<24 {
                let value = Double(dailyRecord[i])
                let entry = BarChartDataEntry(x: Double(i), yValues: [value])
                dataEntriesDay.append(entry)
            }
        }
        
        let chartDataSetDay = BarChartDataSet(values: dataEntriesDay, label: nil)
        //        chartDataSet.stackLabels = ["Drunk"]
        chartDataSetDay.colors = [COLOR_DRUNK]
        chartDataSetDay.drawValuesEnabled = false
        //目前柱状图只包括1组立柱
        let chartDataDay = BarChartData(dataSets: [chartDataSetDay])
        chartDataDay.setValueTextColor(.white)
        chartDataDay.barWidth = 0.7
        return chartDataDay
    }
    
    var avgWeek = 0.0
    fileprivate func generateWeekData() -> BarChartData {
        var dataEntriesWeek = [BarChartDataEntry]()
        var dataEntriesWeekTarget = [BarChartDataEntry]()
        var dateList: [String] = []
        let date = Date()
        let calendar = Calendar.current
        let weekOfDay = calendar.component(.weekday, from: date)

        let lastWeekDate = NSCalendar.current.date(byAdding: .weekOfYear, value: -1, to: NSDate() as Date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        for i in 0..<7 {
            if (weekOfDay > i + 1) {
                let tmpDate = calendar.date(bySetting: .weekday, value: i + 1, of: lastWeekDate!)
                dateList.append(dateFormatter.string(from: tmpDate!))
//                print(dateFormatter.string(from: tmpDate!))
            }
        }
        let getDate = HistoryController.getCurrentDay()
        // print(UserDefaults.standard.double(forKey: getDate + ":day"))
        dateList.append(getDate)
        
        avgWeek = 0.0
        
        // target bar chart
        for i in 0..<7 {
            if (i >= dateList.count) {
                let entry = BarChartDataEntry(x: Double(i), yValues: [0.0])
                dataEntriesWeekTarget.append(entry)
            } else {
                let curTarget = UserDefaults.standard.integer(forKey: getDate + "target")
                let dayCup = UserDefaults.standard.double(forKey: dateList[i] + ":day")
                let value = Double(dayCup)
                let curTar = Double(value / Double(curTarget))
                avgWeek = avgWeek + value
                //                print(value)
                let entry = BarChartDataEntry(x: Double(i), yValues: [Double(curTarget)])
                dataEntriesWeekTarget.append(entry)
            }
        }
        
        let chartDataSetWeekTarget = BarChartDataSet(values: dataEntriesWeekTarget, label: nil)
        chartDataSetWeekTarget.drawValuesEnabled = false
        //        chartDataSet.stackLabels = ["Drunk"]
        chartDataSetWeekTarget.colors = [COLOR_TARGET]
        
        // practical bar chart
        for i in 0..<7 {
            if (i >= dateList.count) {
                let entry = BarChartDataEntry(x: Double(i), yValues: [0.0])
                dataEntriesWeek.append(entry)
            } else {
                let curTarget = UserDefaults.standard.integer(forKey: getDate + "target")
                let dayCup = UserDefaults.standard.double(forKey: dateList[i] + ":day")
                let value = Double(dayCup)
                let curTar = Double(value / Double(curTarget))
                avgWeek = avgWeek + value
//                print(value)
                let entry = BarChartDataEntry(x: Double(i), yValues: [dayCup])  // curTar
                dataEntriesWeek.append(entry)
            }
        }
        
        
        
        print("week" + String(avgWeek))
        avgWeek = Double(round(avgWeek / Double(dateList.count) * 100) / 100)
        
        let chartDataSetWeek = BarChartDataSet(values: dataEntriesWeek, label: nil)
        chartDataSetWeek.drawValuesEnabled = false
        //        chartDataSet.stackLabels = ["Drunk"]
        chartDataSetWeek.colors = [COLOR_DRUNK]
        //目前柱状图只包括1组立柱
        let chartDataWeek = BarChartData(dataSets: [chartDataSetWeekTarget, chartDataSetWeek])
        chartDataWeek.setValueTextColor(.white)
        chartDataWeek.barWidth = 0.7
        return chartDataWeek
    }
    
    var avgMonth = 0.0
    fileprivate func generateMonthData() -> BarChartData {
        var dataEntriesMonth = [BarChartDataEntry]()
        var dataEntriesMonthTarget = [BarChartDataEntry]()
        var dateList: [String] = []
        
        // get the day number of the current date
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        print(day)
        
        // get the first day of the current month
        let firstDate = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date())))!
        print(firstDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"

        for i in 0..<day {
            var newDate = calendar.date(bySetting: .day, value: i + 1, of: firstDate)
            dateList.append(dateFormatter.string(from: newDate!))
            print(dateFormatter.string(from: newDate!))
        }

//        print(getNumOfMonth(year, month))
        let getDate = HistoryController.getCurrentDay()
        avgMonth = 0.0
        
        // target bar chart
        for i in 0..<getNumOfMonth(year, month) {
            if (i < dateList.count) {
                let curTarget = UserDefaults.standard.integer(forKey: getDate + "target")
                let dayCup = UserDefaults.standard.double(forKey: dateList[i] + ":day")
                let value = Double(dayCup)
//                let curTar = Double(value / Double(curTarget))
                avgMonth = avgMonth + value
                let entry = BarChartDataEntry(x: Double(i), yValues: [Double(curTarget)])
                dataEntriesMonthTarget.append(entry)
            } else {
                let entry = BarChartDataEntry(x: Double(i), yValues: [0.0])
                dataEntriesMonthTarget.append(entry)
            }
        }
        print("month" + String(avgMonth))
        avgMonth = Double(round(avgMonth / Double(dateList.count) * 100) / 100)
        
        let chartDataSetMonthTarget = BarChartDataSet(values: dataEntriesMonthTarget, label: nil)
        chartDataSetMonthTarget.drawValuesEnabled = false
        chartDataSetMonthTarget.colors = [COLOR_TARGET]
        
        // practical bar chart
        for i in 0..<getNumOfMonth(year, month) {
            if (i < dateList.count) {
                let curTarget = UserDefaults.standard.integer(forKey: getDate + "target")
                let dayCup = UserDefaults.standard.double(forKey: dateList[i] + ":day")
                let value = Double(dayCup)
//                let curTar = Double(value / Double(curTarget))
                avgMonth = avgMonth + value
                let entry = BarChartDataEntry(x: Double(i), yValues: [value])
                dataEntriesMonth.append(entry)
            } else {
                let entry = BarChartDataEntry(x: Double(i), yValues: [0.0])
                dataEntriesMonth.append(entry)
            }
        }
        print("month" + String(avgMonth))
        avgMonth = Double(round(avgMonth / Double(dateList.count) * 100) / 100)
        
        let chartDataSetMonth = BarChartDataSet(values: dataEntriesMonth, label: nil)
        chartDataSetMonth.drawValuesEnabled = false
        chartDataSetMonth.colors = [COLOR_DRUNK]
        let chartDataMonth = BarChartData(dataSets: [chartDataSetMonthTarget, chartDataSetMonth])
        chartDataMonth.setValueTextColor(.white)
        chartDataMonth.barWidth = 0.7
        return chartDataMonth
    }
    
    lazy var menuSegment: UISegmentedControl = {
        let menu = UISegmentedControl(items: ["Daily", "Weekly", "Monthly"])
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.tintColor = COLOR_THEME_DEEP
        menu.selectedSegmentIndex = 0
        menu.addTarget(self, action: #selector(handleSegmentsAction(sender:)), for: .valueChanged)
        
        return menu
    }()
    
    lazy var barChart: BarChartView = {
        let chart = BarChartView()
        chart.frame = CGRect(x: 5, y: 230, width: 370, height: 380)
        
//        chart.drawValueAboveBarEnabled = false
//        chart.xAxis.centerAxisLabelsEnabled = true
//        chart.xAxis.drawGridLinesEnabled = false
//        chart.xAxis.granularity = 1
        chart.xAxis.labelPosition = .bottom
        chart.xAxis.labelTextColor = .gray
        chart.rightAxis.labelTextColor = .gray
        chart.leftAxis.labelTextColor = .gray
        chart.leftAxis.enabled = false
        chart.drawGridBackgroundEnabled = false
        chart.gridBackgroundColor = .gray
        chart.borderColor = .gray
        
        chart.legend.enabled = false
        
        return chart
    }()
    
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = COLOR_THEME_DEEP
        title.shadowColor = COLOR_THEME
        return title
    }()
    
    lazy var detailLabel: UILabel = {
        let detail = UILabel()
        detail.textColor = COLOR_THEME_DEEP
//        detail.shadowColor = COLOR_THEME
        return detail
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = HISTORY_COLOR
        self.title = "History"
        
        segmentsComponent()
        barChart.data = generateDayData()
        let labels = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16",
                      "17", "18", "19", "20", "21", "22", "23"]
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
        barChart.xAxis.labelCount = labels.count
        barChart.xAxis.granularity = 1
        barChart.xAxis.axisMinimum = 0
        barChart.xAxis.axisMaximum = 23
        barChart.xAxis.forceLabelsEnabled = true
        barChart.xAxis.granularityEnabled = true
        
        barChartComponent()
        titleLabel.text = "Today"
//        titleLabelComponent()
        let currentDayKey2 = HistoryController.getCurrentDay() + ":day"
        let todayConsumption = UserDefaults.standard.double(forKey: currentDayKey2)
        detailLabel.text = "Total: \(todayConsumption) Cups"
        detailLabelComponent()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func handleSegmentsAction(sender: UISegmentedControl) {
        let index = sender.selectedSegmentIndex
        switch index {
        case 0: barChart.data = generateDayData()
                let labels = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16",
                              "17", "18", "19", "20", "21", "22", "23"]
                barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
                barChart.xAxis.labelCount = labels.count
                barChart.xAxis.granularity = 1
                barChart.xAxis.axisMinimum = 0
                barChart.xAxis.axisMaximum = 23
                barChart.xAxis.forceLabelsEnabled = true
                barChart.xAxis.granularityEnabled = true
                titleLabel.text = "Today"
                let currentDayKey2 = HistoryController.getCurrentDay() + ":day"
                let todayConsumption = UserDefaults.standard.double(forKey: currentDayKey2)
                detailLabel.text = "Total: \(todayConsumption) Cups"
        case 1: barChart.data = generateWeekData()
                let labels = ["Sun", "Mon", "Tus", "Wed", "Thu", "Fri", "Sat"]
                barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
                barChart.xAxis.labelCount = 7
                barChart.xAxis.granularity = 1
                barChart.xAxis.axisMinimum = 0
                barChart.xAxis.axisMaximum = 6
                barChart.xAxis.forceLabelsEnabled = true
                barChart.xAxis.granularityEnabled = true
                titleLabel.text = "Current Week"
                detailLabel.text = "Avg: \(avgWeek) Cups Per Day"
        case 2: barChart.data = generateMonthData()
                let date = Date()
                let calendar = Calendar.current
                let year = calendar.component(.year, from: date)
                let month = calendar.component(.month, from: date)
                let days = (getNumOfMonth(year, month))
        
                var labels: [String] = []
                for i in 0..<days {
                    labels.append(String(i + 1))
                }
                barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: labels)
                barChart.xAxis.labelCount = Int(days)
                barChart.xAxis.granularity = 1.0
                barChart.xAxis.axisMinimum = 0
                barChart.xAxis.axisMaximum = Double(days) - 1
                barChart.xAxis.forceLabelsEnabled = true
                barChart.xAxis.granularityEnabled = true
                titleLabel.text = "Current Month"
                detailLabel.text = "Avg: \(avgMonth) Cups Per Day"
        default:
            break
        }
    }
    
    fileprivate func titleLabelComponent() {
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(30)
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(-250)
        }
    }
    
    fileprivate func detailLabelComponent() {
        view.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(30)
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY).offset(280)
            make.left.equalTo(menuSegment.snp.left)
        }
    }
    
    fileprivate func barChartComponent() {
        view.addSubview(barChart)
    }
    
    fileprivate func segmentsComponent() {
        view.addSubview(menuSegment)
        
        menuSegment.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        menuSegment.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -220).isActive = true
        menuSegment.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        menuSegment.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        menuSegment.heightAnchor.constraint(equalToConstant: 50)
            

//        menuSegment.snp.makeConstraints { (make) -> Void in
//            make.height.equalTo(30)
//            make.top.equalTo(self.view.snp.top).offset(8)
//            make.left.equalTo(self.view.snp.left).offset(20)
//            make.right.equalTo(self.view.snp.right).offset(-20)
//        }
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
    
    fileprivate func getNumOfMonth(_ y: Int, _ m: Int) -> Int {
        let dateComponents = DateComponents(year: y, month: m)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
}
