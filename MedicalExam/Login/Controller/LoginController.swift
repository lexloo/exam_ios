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

class LoginController: UIViewController {    
    @IBOutlet weak var txtMobile: UITextField!
    
    @IBOutlet weak var txtPasswd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login(_ sender: Any) {
        let parameters: Dictionary = ["mobile": txtMobile.text!, "password": txtPasswd.text!]
        
        HttpUtil.postReturnResult("user/login", parameters: parameters) {
            json in
            let userInfo = UserInfo()
            userInfo.mapping(json)
            
            RealmUtil.addCanUpdate(userInfo)
            if userInfo.examKind != nil {
                //goto main controller
                let main = MainViewController()
                self.present(main, animated: true, completion: nil)
            } else {
                //select category
                let selectCategoryVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectCategoryVC")
                self.present(selectCategoryVC!, animated: true, completion: nil)
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
}
