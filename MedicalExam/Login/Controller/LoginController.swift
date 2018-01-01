//
//  LogonController.swift
//  MedicalExam
//
//  Created by 黄奇 on 30/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//
import UIKit
import Foundation

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
        print("login")
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
