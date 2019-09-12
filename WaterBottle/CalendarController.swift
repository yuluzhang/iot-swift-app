//
//  CalendarController.swift
//  WaterBottle
//
//  Created by 张涵雅 on 2/22/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit
import FSCalendar
import SnapKit

let CALENDAR_COLOR = UIColor(hex: "#0984e3")
let CALENDAR_HEADER = UIColor(hex: "#2d3436")
let CALENDAR_SUB_HEADER = UIColor(hex: "#636e72")
let CALENDAR_TEXT = UIColor(hex: "#dfe6e9")
let CALENDAR_TEXT_SELECTED = UIColor(hex: "#636e72")

class CalendarController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
    
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    fileprivate weak var calendar: FSCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CALENDAR_COLOR
        
        self.title = "calendar"
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 80, width: 400, height: 700))
        calendar.dataSource = self
        calendar.delegate = self
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 18)
        calendar.appearance.headerTitleColor = CALENDAR_HEADER
        calendar.appearance.weekdayFont = UIFont.systemFont(ofSize: 16)
        calendar.appearance.weekdayTextColor = CALENDAR_SUB_HEADER
        calendar.appearance.titleDefaultColor = CALENDAR_TEXT
//        calendar.appearance.selectionColor = CALENDAR_TEXT_SELECTED
        calendar.appearance.todayColor = CALENDAR_TEXT_SELECTED
       
        self.hideKeyboardWhenTappedAround()
        view.addSubview(calendar)
        self.calendar = calendar
    }
    
    func jumpToThatDay(_ date: String) {
        navigationController?.popViewController(animated: true)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "YYYYMMdd"
        let customDate = dateformatter.string(from: date)
        jumpToThatDay(customDate)
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { (make) -> Void in
            make.height.equalTo(bounds.height)
        }
    }
}
