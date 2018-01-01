//
//  LogonController.swift
//  MedicalExam
//
//  Created by 黄奇 on 30/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//
import UIKit
import Foundation
import Alamofire

class LoginController: UIViewController {
    let URL_PREFIX = "http://192.168.1.6/question-bank/v1/"
    
    @IBOutlet weak var txtMobile: UITextField!
    
    @IBOutlet weak var txtPasswd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login(_ sender: Any) {
        print("login" + URL_PREFIX + "user/login")
        let parameters: Dictionary = ["mobile": txtMobile.text!, "password": txtPasswd.text!]
        Alamofire.request(URL_PREFIX + "user/login", method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON {
            response in
            
            if let json = response.result.value {
                print("\(response.result.value)");
            }
            print(response.result)
        }
        print("login3")
        
        //print("login")
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
