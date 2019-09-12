//
//  ChangePasswordController.swift
//  WaterBottle
//
//  Created by Yulu Zhang on 2/25/19.
//  Copyright © 2019 yulu zhang. All rights reserved.
//

import UIKit

class ChangePasswordController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = COLOR_THEME
        self.hideKeyboardWhenTappedAround()
        changePasswordPageComponents()
        self.title = "Change Password"
        self.tabBarController?.tabBar.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    //        let tabbar disappear when goes back
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    let currentTextField: UITextField =  {
        let current = UITextField()
        let currentAttributePlaceholder = NSAttributedString(string: "Current Password", attributes: [.foregroundColor: UIColor.white])
        current.attributedPlaceholder = currentAttributePlaceholder
        current.backgroundColor = COLOR_THEME
        current.textColor = .white
        current.isSecureTextEntry = true
        current.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        current.layer.shadowOpacity = 1
        current.layer.shadowRadius = 0
        current.layer.shadowColor = UIColor.white.cgColor
        return current
    } ()
    
    let newTextField: UITextField =  {
        let newp = UITextField()
        let newpAttributePlaceholder = NSAttributedString(string: "New Password", attributes: [.foregroundColor: UIColor.white])
        newp.attributedPlaceholder = newpAttributePlaceholder
        newp.backgroundColor = COLOR_THEME
        newp.textColor = .white
        newp.isSecureTextEntry = true
        newp.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        newp.layer.shadowOpacity = 1
        newp.layer.shadowRadius = 0
        newp.layer.shadowColor = UIColor.white.cgColor
        return newp
    } ()
    
    let confirmTextField: UITextField =  {
        let confirm = UITextField()
        let confirmAttributePlaceholder = NSAttributedString(string: "Confirm Password", attributes: [.foregroundColor: UIColor.white])
        confirm.attributedPlaceholder = confirmAttributePlaceholder
        confirm.backgroundColor = COLOR_THEME
        confirm.textColor = .white
        confirm.isSecureTextEntry = true
        confirm.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        confirm.layer.shadowOpacity = 1
        confirm.layer.shadowRadius = 0
        confirm.layer.shadowColor = UIColor.white.cgColor
        return confirm
    } ()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"6")
        return image
    }()
    
    let confirmBtn: UIButton = {
        let fooBtn = UIButton()
        fooBtn.setImage(UIImage(named: "confirmBtn"), for: .normal)
        fooBtn.addTarget(self, action: #selector(gohome_page), for: .touchUpInside)
        return fooBtn
    }()
    
    
    fileprivate func currentComponent() {
        view.addSubview(currentTextField)
        
        currentTextField.snp.makeConstraints { (current) -> Void in
            current.height.size.equalTo(40)
            current.top.equalTo(self.view.snp.top).offset(100)
            current.left.equalTo(self.view.snp.left).offset(35)
            current.right.equalTo(self.view.snp.right).offset(-35)
        }
    }
    
    fileprivate func newComponent() {
        view.addSubview(newTextField)
        
        newTextField.snp.makeConstraints { (newp) -> Void in
            newp.height.size.equalTo(40)
            newp.top.equalTo(currentTextField.snp.bottom).offset(8)
            newp.left.equalTo(currentTextField.snp.left)
            newp.right.equalTo(currentTextField.snp.right)
        }
    }
    
    fileprivate func confirmComponent() {
        view.addSubview(confirmTextField)
        
        confirmTextField.snp.makeConstraints { (confirm) -> Void in
            confirm.height.size.equalTo(40)
            confirm.top.equalTo(newTextField.snp.bottom).offset(8)
            confirm.left.equalTo(newTextField.snp.left)
            confirm.right.equalTo(newTextField.snp.right)
        }
    }
    
    fileprivate func pictureComponents() {
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.width.size.equalTo(350)
            make.top.equalTo(self.view.snp.top).offset(200)
            make.centerX.equalTo(self.view)
        }
    }
    
    fileprivate func confirmComponents() {
        view.addSubview(confirmBtn)
        confirmBtn.contentMode = .scaleAspectFit
        confirmBtn.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.top.equalTo(imageView.snp.bottom).offset(3)
            make.centerX.equalTo(self.view)
        }
        confirmBtn.layer.cornerRadius = 30
    }
    
    
    @objc func gohome_page() {
        navigationController?.popViewController(animated: true)
    }
    
    
    fileprivate func changePasswordPageComponents() {
        currentComponent()
        newComponent()
        confirmComponent()
        pictureComponents()
        confirmComponents()
    }
    
}


