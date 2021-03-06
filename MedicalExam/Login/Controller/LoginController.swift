//
//  LogonController.swift
//  MedicalExam
//
//  Created by 黄奇 on 30/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//
import UIKit
import Foundation
import SwiftyJSON

class LoginController: BaseUIViewController {    
    @IBOutlet weak var txtMobile: UITextField!
    
    @IBOutlet weak var txtPasswd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Thread.sleep(forTimeInterval: 10)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login(_ sender: Any) {
        let parameters: Dictionary = ["mobile": txtMobile.text!, "password": txtPasswd.text!]
        
        HttpUtil.postReturnResult("user/login", parameters: parameters, viewController: self) {
            json in

            let userInfo = UserInfo()
            userInfo.mapping(json)
            Global.userInfo.copyFrom(userInfo)
            
            RealmUtil.addCanUpdate(userInfo)

            //if don't have subjects, then show select subjects and chapters dialog
            let count = RealmUtil.selectAll(Subject.self).count
            print(count)
            if count > 0 {
                //goto main controller
                let main = MainViewController()
                self.present(main, animated: true, completion: nil)
            } else {
                //select category
                let selectKindVC = SelectKindController()
                self.present(selectKindVC, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func onDoex(_ sender: UITextField) {
        sender.resignFirstResponder()
        
        print("click")
    }
    
    @IBAction func backTap(_ sender: Any) {
        txtMobile.resignFirstResponder()
        txtPasswd.resignFirstResponder()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
