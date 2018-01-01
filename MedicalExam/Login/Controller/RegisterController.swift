//
//  RegisterController.swift
//  MedicalExam
//
//  Created by 黄奇 on 01/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import UIKit
import Foundation

class RegisterController: UIViewController {
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtVerifyCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func goLogin() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onFieldExit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func backTap(_ sender: UIControl) {
        self.txtMobile.resignFirstResponder()
        self.txtName.resignFirstResponder()
        self.txtPassword.resignFirstResponder()
        self.txtVerifyCode.resignFirstResponder()
    }
}
