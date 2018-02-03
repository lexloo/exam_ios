//
//  BaseUITableViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 03/02/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit

class BaseUITableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = BaseColor.statusBarColor
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func publishNotification(name: String, userInfo: [AnyHashable: Any]?) {
        let notificationName = Notification.Name(name)
        NotificationCenter.default.post(name: notificationName, object: self, userInfo: userInfo)
    }
    
    func subscribeNotification(name: String, selector: Selector) {
        let notificationName = Notification.Name(name)
        
        NotificationCenter.default.addObserver(self, selector: selector, name: notificationName, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
