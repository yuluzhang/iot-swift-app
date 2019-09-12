//
//  VerifyEmailController.swift
//  WaterBottle
//
//  Created by Yulu Zhang on 2/25/19.
//  Copyright © 2019 Yulu Zhang. All rights reserved.
//

import UIKit

class VerifyEmailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = COLOR_THEME
        //to do: keyboard
        self.hideKeyboardWhenTappedAround()
        verifyPageComponents()
        self.title = "Verify Email"
        self.tabBarController?.tabBar.isHidden = true
    }

    @objc func return_lastpage() {
        navigationController?.popViewController(animated: true)
    }

    //load image:
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named:"6")
        return image
    }()
    
    //confirm button
    let confirmBtn: UIButton = {
        let fooBtn = UIButton()
        fooBtn.setImage(UIImage(named: "confirmBtn"), for: .normal)
        fooBtn.addTarget(self, action: #selector(gohome_page), for: .touchUpInside)
        return fooBtn
    }()
    
    //email text
    let emailTextField: UITextField =  {
        let email = UITextField()
        let pemailAttributePlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.white])
        email.attributedPlaceholder = pemailAttributePlaceholder
        email.backgroundColor = COLOR_THEME
        email.textColor = .white
        email.isSecureTextEntry = false
        email.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        email.layer.shadowOpacity = 1
        email.layer.shadowRadius = 0
        email.layer.shadowColor = UIColor.white.cgColor
        return email
    } ()
    
    
    let codeTextField: UITextField =  {
        let code = UITextField()
        let codeAttributePlaceholder = NSAttributedString(string: "Code", attributes: [.foregroundColor: UIColor.white])
        code.attributedPlaceholder = codeAttributePlaceholder
        code.backgroundColor = COLOR_THEME
        code.textColor = .white
        code.isSecureTextEntry = false
        code.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        code.layer.shadowOpacity = 1
        code.layer.shadowRadius = 0
        code.layer.shadowColor = UIColor.white.cgColor
        return code
    } ()
    
    
    let sendCodeButton: UIButton =  {
        let s = UIButton()
        s.setTitle("Send Code", for:UIControl.State.normal)
        s.backgroundColor = COLOR_THEME
        s.setTitleColor(.white, for: .normal)
        return s
    } ()
    
    //top bar to be white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    fileprivate func emailComponent() {
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { (email) -> Void in
            email.height.equalTo(40)
            email.top.equalTo(self.view.snp.top).offset(350)
            email.left.equalTo(self.view.snp.left).offset(35)
            email.right.equalTo(self.view.snp.right).offset(-35)
        }
    }
    
    fileprivate func codeComponent() {
        view.addSubview(codeTextField)
        
        codeTextField.snp.makeConstraints { (code) -> Void in
            code.height.equalTo(40)
            code.top.equalTo(emailTextField.snp.bottom).offset(8)
            code.left.equalTo(emailTextField.snp.left)
            code.right.equalTo(emailTextField.snp.right)
        }
    }
    
    fileprivate func sendComponents() {
        codeTextField.addSubview(sendCodeButton)
        sendCodeButton.sizeToFit()
        sendCodeButton.snp.makeConstraints { (send) -> Void in
            send.centerY.equalTo(codeTextField)
            send.right.equalTo(codeTextField.snp.right).offset(-10)
        }
        sendCodeButton.setTitleColor(.black, for: UIControl.State.highlighted)
    }
    
    fileprivate func pictureComponents() {
        view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        
        imageView.snp.makeConstraints { (make) -> Void in
            make.width.size.equalTo(250)
            make.top.equalTo(self.view.snp.top).offset(100)
            make.centerX.equalTo(self.view)
        }
    }
    
    fileprivate func confirmComponents() {
        view.addSubview(confirmBtn)
        confirmBtn.contentMode = .scaleAspectFit
        confirmBtn.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.top.equalTo(self.view.snp.top).offset(500)
            make.centerX.equalTo(self.view)
        }
        confirmBtn.layer.cornerRadius = 30
    }
    
    
    @objc func gohome_page() {
        UserDefaults.standard.set(true, forKey: "didLogIn")
//        navigationController?.pushViewController(HomeController(), animated: true)
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func verifyPageComponents() {
        emailComponent()
        codeComponent()
        sendComponents()
        pictureComponents()
        confirmComponents()
    }
    
}
