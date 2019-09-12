//
//  RegisterController.swift
//  WaterBottle
//
//  Created by 张涵雅 on 2/20/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit
import SnapKit


class RegisterController: UIViewController {
    
    let logoImage2: UIImageView =  {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.contentMode = .scaleAspectFit
        return logo
    } ()
    
    let usernameTextField: UITextField =  {
        let username = UITextField()
        let usernameAttributePlaceholder = NSAttributedString(string: "Username", attributes: [.foregroundColor: UIColor.white])
        username.attributedPlaceholder = usernameAttributePlaceholder
        username.backgroundColor = COLOR_THEME
        username.textColor = .white
        username.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        username.layer.shadowOpacity = 1
        username.layer.shadowRadius = 0
        username.layer.shadowColor = UIColor.white.cgColor
        return username
    } ()
    
    let passwordTextField: UITextField =  {
        let pwd = UITextField()
        let pwdAttributePlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.white])
        pwd.attributedPlaceholder = pwdAttributePlaceholder
        pwd.backgroundColor = COLOR_THEME
        pwd.textColor = .white
        pwd.isSecureTextEntry = true
        pwd.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        pwd.layer.shadowOpacity = 1
        pwd.layer.shadowRadius = 0
        pwd.layer.shadowColor = UIColor.white.cgColor
        return pwd
    } ()
    
    let passwordConfirmTextField: UITextField =  {
        let pwdConfirm = UITextField()
        let pwdAttributePlaceholder = NSAttributedString(string: "Confirm Password", attributes: [.foregroundColor: UIColor.white])
        pwdConfirm.attributedPlaceholder = pwdAttributePlaceholder
        pwdConfirm.backgroundColor = COLOR_THEME
        pwdConfirm.textColor = .white
        pwdConfirm.isSecureTextEntry = true
        pwdConfirm.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        pwdConfirm.layer.shadowOpacity = 1
        pwdConfirm.layer.shadowRadius = 0
        pwdConfirm.layer.shadowColor = UIColor.white.cgColor
        return pwdConfirm
    } ()
    
    let emailTextField: UITextField =  {
        let email = UITextField()
        let emailAttributePlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.white])
        email.attributedPlaceholder = emailAttributePlaceholder
        email.backgroundColor = COLOR_THEME
        email.textColor = .white
        email.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        email.layer.shadowOpacity = 1
        email.layer.shadowRadius = 0
        email.layer.shadowColor = UIColor.white.cgColor
        return email
    } ()
    
    let registerButton: UIButton = {
        let register = UIButton(type: .system)
        register.setTitle("Sign Up", for: .normal)
        register.setTitleColor(.white, for: .normal)
        register.backgroundColor = COLOR_THEME_DEEP
        register.layer.cornerRadius = 15
        register.addTarget(self, action: #selector(settingsAction), for: .touchUpInside)
        return register
    }()
    
    let loginButton: UIButton = {
        let login = UIButton(type: .system)
        login.backgroundColor = COLOR_THEME
        let loginAttributeTitle = NSMutableAttributedString(string: "Already have an account?",
                                                            attributes: [.foregroundColor: COLOR_THEME_DEEP,
                                                                         .font: UIFont.systemFont(ofSize: 16)])
        loginAttributeTitle.append(NSAttributedString(string: "  Log in", attributes: [.foregroundColor: UIColor.white,
                                                                                       .font: UIFont.systemFont(ofSize: 16)]))
        login.setAttributedTitle(loginAttributeTitle, for: .normal)
        login.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return login
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = COLOR_THEME
        self.hideKeyboardWhenTappedAround()
        registerPageComponents()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc func loginAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func settingsAction() {
        UserDefaults.standard.set(true, forKey: "didLogIn")
        //let settings = ProfileSettingsController() // FirsttimeProfileSettingController
        let settings = ProfileSettingsControllerTwo() // FirsttimeProfileSettingController

        
        navigationController?.pushViewController(settings, animated: true)
//        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func logoComponent2() {
        view.addSubview(logoImage2)
        
        logoImage2.snp.makeConstraints { (logo) -> Void in
            logo.height.equalTo(150)
            logo.top.equalTo(self.view.snp.top).offset(150)
            logo.left.equalTo(self.view.snp.left).offset(50)
            logo.right.equalTo(self.view.snp.right).offset(-50)
        }
    }
    
    fileprivate func usernameComponent() {
        view.addSubview(usernameTextField)
        
        usernameTextField.snp.makeConstraints { (username) -> Void in
            username.height.equalTo(40)
            username.top.equalTo(self.view.snp.top).offset(350)
            username.left.equalTo(self.view.snp.left).offset(35)
            username.right.equalTo(self.view.snp.right).offset(-35)
        }
    }
    
    fileprivate func passwordComponent() {
        view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { (password) -> Void in
            password.height.equalTo(40)
            password.top.equalTo(usernameTextField.snp.bottom).offset(8)
            password.left.equalTo(usernameTextField.snp.left)
            password.right.equalTo(usernameTextField.snp.right)
        }
    }
    
    fileprivate func passwordConfirmComponent() {
        view.addSubview(passwordConfirmTextField)
        
        passwordConfirmTextField.snp.makeConstraints { (password) -> Void in
            password.height.equalTo(40)
            password.top.equalTo(passwordTextField.snp.bottom).offset(8)
            password.left.equalTo(usernameTextField.snp.left)
            password.right.equalTo(usernameTextField.snp.right)
        }
    }
    
    fileprivate func emailComponent() {
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { (email) -> Void in
            email.height.equalTo(40)
            email.top.equalTo(passwordConfirmTextField.snp.bottom).offset(8)
            email.left.equalTo(usernameTextField.snp.left)
            email.right.equalTo(usernameTextField.snp.right)
        }
    }
    
    fileprivate func registerButtonComponent() {
        view.addSubview(registerButton)
        
        registerButton.snp.makeConstraints { (register) -> Void in
            register.height.equalTo(50)
            register.top.equalTo(emailTextField.snp.bottom).offset(30)
            register.left.equalTo(usernameTextField.snp.left)
            register.right.equalTo(usernameTextField.snp.right)
        }
    }
    
    fileprivate func loginButtonComponent() {
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { (login) -> Void in
            login.height.equalTo(30)
            login.bottom.equalTo(self.view.snp.bottom).offset(-16)
            login.left.equalTo(self.view.snp.left).offset(50)
            login.right.equalTo(self.view.snp.right).offset(-50)
        }
    }
    
    fileprivate func registerPageComponents() {
        logoComponent2()
        loginButtonComponent()
        usernameComponent()
        passwordComponent()
        passwordConfirmComponent()
        emailComponent()
        registerButtonComponent()
        loginButtonComponent()
    }
}
