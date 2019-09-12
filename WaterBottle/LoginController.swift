//
//  ViewController.swift
//  WaterBottle
//
//  Created by 张涵雅 on 2/20/19.
//  Copyright © 2019 张涵雅. All rights reserved.
//

import UIKit
import SnapKit


//let COLOR_THEME = UIColor(displayP3Red: 109 / 255, green: 149 / 255, blue: 201 / 255, alpha: 1)
//let COLOR_THEME_DEEP = UIColor(red: 89 / 255, green: 120 / 255, blue: 156 / 255, alpha: 1)
let COLOR_THEME = UIColor(hex: "7AC7CF")
let COLOR_THEME_DEEP = UIColor(hex: "8395a7") // #8395a7   2499B2
let COLOR_THEME1 = UIColor(hex: "7AB9EA")
let COLOR_THEME_DEEP1 = UIColor(hex: "247BBF")
let COLOR_TITLE = UIColor(hex: "ff7675")
let COLOR_TARGET = UIColor(hex: "fdcb6e")
let COLOR_DRUNK = UIColor(hex: "74b9ff")
let COLOR_TINT = UIColor(hex: "dfe6e9")
let COLOR_TABBAR = UIColor(hex: "222f3e")
let COLOR_GOOD = UIColor(hex: "33d9b2")
let COLOR_EXCELLENT = UIColor(hex: "0fbcf9")
let COLOR_TOOMUCH = UIColor(hex: "ff5252")

let starttime = 8 * 60
let endtime = 22 * 60

class LoginController: UIViewController {
    
    let logoImage: UIImageView =  {
        let logo = UIImageView()
        logo.image = UIImage(named: "icon")
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
    
    let loginButton: UIButton = {
        let login = UIButton(type: .system)
        login.setTitle("Log In", for: .normal)
        login.setTitleColor(.white, for: .normal)
        login.backgroundColor = COLOR_THEME_DEEP
        login.layer.cornerRadius = 15
        login.addTarget(self, action: #selector(tabBarAction), for: .touchUpInside)
        return login
    }()
    
    let forgetButton: UIButton = {
        let forget = UIButton(type: .system)
        forget.setTitle("Forget Your Password?", for: .normal)
        forget.setTitleColor(.white, for: .normal)
        forget.backgroundColor = COLOR_THEME
        forget.addTarget(self, action: #selector(forgetPassword), for: .touchUpInside)
        return forget
    }()
    
    let registerButton: UIButton = {
        let register = UIButton(type: .system)
        register.backgroundColor = COLOR_THEME
        let registerAttributeTitle = NSMutableAttributedString(string: "Don't have an account?",
                                                               attributes: [.foregroundColor: COLOR_THEME_DEEP,
                                                                            .font: UIFont.systemFont(ofSize: 16)])
        registerAttributeTitle.append(NSAttributedString(string: "  Sign Up", attributes: [.foregroundColor: UIColor.white,
                                                                                         .font: UIFont.systemFont(ofSize: 16)]))
        register.setAttributedTitle(registerAttributeTitle, for: .normal)
        register.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return register
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = COLOR_THEME
        self.hideKeyboardWhenTappedAround()
        loginPageComponents()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        navigationController?.isNavigationBarHidden = true
//    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func registerAction() {
        let register = RegisterController()
        navigationController?.pushViewController(register, animated: true)
    }
    
    @objc func tabBarAction() {
        UserDefaults.standard.set(true, forKey: "didLogIn")
        self.dismiss(animated: true, completion: nil)
        
//        let home = HomeController()
//        navigationController?.pushViewController(home, animated: true)
    }
    
    @objc func forgetPassword() {
        let fetchPassword = VerifyEmailViewController()
        navigationController?.pushViewController(fetchPassword, animated: true)
    }
    
    fileprivate func logoComponent() {
        view.addSubview(logoImage)
        
        logoImage.snp.makeConstraints { (logo) -> Void in
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
    
    fileprivate func loginButtonComponent() {
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { (login) -> Void in
            login.height.equalTo(50)
            login.top.equalTo(passwordTextField.snp.bottom).offset(30)
            login.left.equalTo(usernameTextField.snp.left)
            login.right.equalTo(usernameTextField.snp.right)
        }
    }
    
    fileprivate func registerButtonComponent() {
        view.addSubview(registerButton)
        
        registerButton.snp.makeConstraints { (register) -> Void in
            register.height.equalTo(30)
            register.bottom.equalTo(self.view.snp.bottom).offset(-16)
            register.left.equalTo(self.view.snp.left).offset(50)
            register.right.equalTo(self.view.snp.right).offset(-50)
        }
    }
    
    fileprivate func forgetButtonComponent() {
        view.addSubview(forgetButton)
        
        forgetButton.snp.makeConstraints { (forget) -> Void in
            forget.height.equalTo(30)
            forget.top.equalTo(loginButton.snp.bottom).offset(8)
            forget.left.equalTo(self.view.snp.left).offset(70)
            forget.right.equalTo(self.view.snp.right).offset(-70)
        }
    }
    
    fileprivate func loginPageComponents() {
        usernameComponent()
        passwordComponent()
        loginButtonComponent()
        registerButtonComponent()
        forgetButtonComponent()
        logoComponent()
    }
}
