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
    @IBOutlet weak var navigationBar: UINavigationBar!

    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtVerifyCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.pushItem(self.makeNavItem(), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func goLogin() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeNavItem() -> UINavigationItem  {
        let item: UINavigationItem = UINavigationItem()
        let leftButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(goLogin))
        
        item.title = "注册"
        item.setLeftBarButton(leftButton, animated: true)
        
        return item
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
