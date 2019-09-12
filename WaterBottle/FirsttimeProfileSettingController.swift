//
//  FirsttimeProfileSettingController.swift
//  WaterBottle
//
//  Created by Yulu Zhang on 2/25/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit

class FirsttimeProfileSettingController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = COLOR_THEME
        self.hideKeyboardWhenTappedAround()
        profilePageComponents()
        self.title = "new Profiles"
        self.tabBarController?.tabBar.isHidden = true

    }
    
    let ageTextField: UITextField =  {
        let age = UITextField()
        let ageAttributePlaceholder = NSAttributedString(string: "*Age", attributes: [.foregroundColor: UIColor.white])
        age.attributedPlaceholder = ageAttributePlaceholder
        age.backgroundColor = COLOR_THEME
        age.textColor = .white
        age.isSecureTextEntry = false
        age.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        age.layer.shadowOpacity = 1
        age.layer.shadowRadius = 0
        age.layer.shadowColor = UIColor.white.cgColor
        return age
    } ()
    
    let genderTextField: UITextField =  {
        let gender = UITextField()
        let genderAttributePlaceholder = NSAttributedString(string: "*Gender", attributes: [.foregroundColor: UIColor.white])
        gender.attributedPlaceholder = genderAttributePlaceholder
        gender.backgroundColor = COLOR_THEME
        gender.textColor = .white
        gender.isSecureTextEntry = false
        gender.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        gender.layer.shadowOpacity = 1
        gender.layer.shadowRadius = 0
        gender.layer.shadowColor = UIColor.white.cgColor
        return gender
    } ()
    
    let occupationTextField: UITextField =  {
        let occupation = UITextField()
        let occupationAttributePlaceholder = NSAttributedString(string: "Occupation", attributes: [.foregroundColor: UIColor.white])
        occupation.attributedPlaceholder = occupationAttributePlaceholder
        occupation.backgroundColor = COLOR_THEME
        occupation.textColor = .white
        occupation.isSecureTextEntry = false
        occupation.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        occupation.layer.shadowOpacity = 1
        occupation.layer.shadowRadius = 0
        occupation.layer.shadowColor = UIColor.white.cgColor
        return occupation
    } ()
    
    
    let healthConditionTextField: UITextField =  {
        let health = UITextField()
        let healthAttributePlaceholder = NSAttributedString(string: "Health Condition", attributes: [.foregroundColor: UIColor.white])
        health.attributedPlaceholder = healthAttributePlaceholder
        health.backgroundColor = COLOR_THEME
        health.textColor = .white
        health.isSecureTextEntry = false
        health.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        health.layer.shadowOpacity = 1
        health.layer.shadowRadius = 0
        health.layer.shadowColor = UIColor.white.cgColor
        return health
    } ()
    
    let bottleSizeTextField: UITextField =  {
        let bottle = UITextField()
        let bottleAttributePlaceholder = NSAttributedString(string: "*Bottle Size", attributes: [.foregroundColor: UIColor.white])
        bottle.attributedPlaceholder = bottleAttributePlaceholder
        bottle.backgroundColor = COLOR_THEME
        bottle.textColor = .white
        bottle.isSecureTextEntry = false
        bottle.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        bottle.layer.shadowOpacity = 1
        bottle.layer.shadowRadius = 0
        bottle.layer.shadowColor = UIColor.white.cgColor
        return bottle
    } ()
    
    let targetIntakeTextField: UITextField =  {
        let intake = UITextField()
        let intakeAttributePlaceholder = NSAttributedString(string: "*Target Intake", attributes: [.foregroundColor: UIColor.white])
        intake.attributedPlaceholder = intakeAttributePlaceholder
        intake.backgroundColor = COLOR_THEME
        intake.textColor = .white
        intake.isSecureTextEntry = false
        intake.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        intake.layer.shadowOpacity = 1
        intake.layer.shadowRadius = 0
        intake.layer.shadowColor = UIColor.white.cgColor
        return intake
    } ()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"7")
        return image
    }()
    
    let confirmBtn: UIButton = {
        let fooBtn = UIButton()
        fooBtn.setImage(UIImage(named: "confirmBtn"), for: .normal)
        fooBtn.addTarget(self, action: #selector(notification_page), for: .touchUpInside)
        return fooBtn
    }()
    
    
    fileprivate func ageComponent() {
        view.addSubview(ageTextField)
        
        ageTextField.snp.makeConstraints { (age) -> Void in
            age.height.size.equalTo(40)
            age.top.equalTo(self.view.snp.top).offset(100)
            age.left.equalTo(self.view.snp.left).offset(35)
            age.right.equalTo(self.view.snp.right).offset(-35)
        }
    }
    
    fileprivate func genderComponent() {
        view.addSubview(genderTextField)
        
        genderTextField.snp.makeConstraints { (gender) -> Void in
            gender.height.size.equalTo(40)
            gender.top.equalTo(ageTextField.snp.bottom).offset(8)
            gender.left.equalTo(ageTextField.snp.left)
            gender.right.equalTo(ageTextField.snp.right)
        }
    }
    
    fileprivate func occupationComponent() {
        view.addSubview(occupationTextField)
        
        occupationTextField.snp.makeConstraints { (occupation) -> Void in
            occupation.height.size.equalTo(40)
            occupation.top.equalTo(genderTextField.snp.bottom).offset(8)
            occupation.left.equalTo(genderTextField.snp.left)
            occupation.right.equalTo(genderTextField.snp.right)
        }
    }
    
    fileprivate func healthComponent() {
        view.addSubview(healthConditionTextField)
        
        healthConditionTextField.snp.makeConstraints { (health) -> Void in
            health.height.size.equalTo(40)
            health.top.equalTo(occupationTextField.snp.bottom).offset(8)
            health.left.equalTo(occupationTextField.snp.left)
            health.right.equalTo(occupationTextField.snp.right)
        }
    }
    
    fileprivate func bottleComponent() {
        view.addSubview(bottleSizeTextField)
        
        bottleSizeTextField.snp.makeConstraints { (bottle) -> Void in
            bottle.height.size.equalTo(40)
            bottle.top.equalTo(healthConditionTextField.snp.bottom).offset(8)
            bottle.left.equalTo(healthConditionTextField.snp.left)
            bottle.right.equalTo(healthConditionTextField.snp.right)
        }
    }
    
    fileprivate func intakeComponent() {
        view.addSubview(targetIntakeTextField)
        
        targetIntakeTextField.snp.makeConstraints { (target) -> Void in
            target.height.size.equalTo(40)
            target.top.equalTo(bottleSizeTextField.snp.bottom).offset(8)
            target.left.equalTo(bottleSizeTextField.snp.left)
            target.right.equalTo(bottleSizeTextField.snp.right)
        }
    }
    
    
    fileprivate func pictureComponents() {
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.width.size.equalTo(350)
            make.top.equalTo(self.view.snp.top).offset(400)
            make.centerX.equalTo(self.view)
        }
    }
    
    fileprivate func confirmComponents() {
        view.addSubview(confirmBtn)
        confirmBtn.contentMode = .scaleAspectFit
        confirmBtn.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.top.equalTo(imageView.snp.bottom)
            //           / make.top.equalTo(imageView.view.snp.top).offset(800)
            make.centerX.equalTo(self.view)
        }
        confirmBtn.layer.cornerRadius = 30
    }
    
    fileprivate func profilePageComponents() {
        ageComponent()
        genderComponent()
        occupationComponent()
        healthComponent()
        bottleComponent()
        intakeComponent()
        pictureComponents()
        confirmComponents()
    }
    
    //if it is after registration page, then next go to notification page
    //else go to manage account page
    @objc func notification_page() {
        UserDefaults.standard.set(true, forKey: "didLogIn")
        navigationController?.dismiss(animated: true, completion: nil)

        //navigationController?.pushViewController(HomeController(), animated: true)
    }
    
}

