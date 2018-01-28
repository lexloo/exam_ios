//
//  BaseUIViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 21/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit

class BaseUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = BaseColor.statusBarColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("baseUi")
        NotificationCenter.default.removeObserver(self)
    }
}
