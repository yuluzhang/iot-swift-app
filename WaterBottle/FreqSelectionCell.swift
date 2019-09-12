//
//  FreqSelectionCell.swift
//  WaterBottle
//
//  Created by Yulu Zhang on 2/25/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//
import UIKit
class FreqSelectionCell: UITableViewCell {
    var checkMark: UIImageView!
    convenience init(name: String) {
        self.init()
        self.textLabel?.text = name
        
        checkMark = UIImageView(imageName: "home1", desiredSize: CGSize(width: 15, height: 15))
        
        self.addSubview(checkMark)
        checkMark.isHidden = true
        checkMark.snp.makeConstraints {
            make in
            make.centerY.equalTo(self)
            make.right.equalTo(self).offset(-15)
        }
    }
    
    func showCheckMark() {
        checkMark.isHidden = false
    }
    
    func removeCheckMark() {
        checkMark.isHidden = true
    }
}
