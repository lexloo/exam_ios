//
//  RegisterController.swift
//  MedicalExam
//
//  Created by 黄奇 on 01/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import UIKit
import Foundation

class RegisterController: UITableViewController {
    @IBOutlet weak var tfMobile: UITextField!
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassWord: UITextField!
    @IBOutlet weak var tfVerifyCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfMobile.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnVerfiyCode(_ sender: UIButton) {
    }
    @IBAction func Register(_ sender: UIButton) {
        let mobile = tfMobile.text!
        if mobile.count < 10 {
            MessageUtils.alert(viewController: self, message: "请输入手机号码")
            
            return
        }
        
        let userName = tfUserName.text!
        if userName.count < 2 {
            MessageUtils.alert(viewController: self, message: "用户名太短")
            
            return
        }
        
        let password = tfPassWord.text!
        if password.count < 4 {
            MessageUtils.alert(viewController: self, message: "请输入4位以上密码")
            
            return
        }
        
        let verifyCode = tfVerifyCode.text!
        if verifyCode.count != 4 {
            MessageUtils.alert(viewController: self, message: "请输入4位验证码")
            
            return
        }
        
        let parameters = ["mobile": mobile, "name": userName, "password": password, "verifyCode": verifyCode]
        
        HttpUtil.postReturnResult("user/register", parameters: parameters, viewController: self) {
            json in
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
