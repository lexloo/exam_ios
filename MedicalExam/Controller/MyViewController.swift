//
//  MyViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 24/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//

import UIKit

class MyViewController: UITableViewController {
    @IBOutlet weak var vLogo: UIView!
    
    @IBAction func exitClick(_ sender: UIButton) {
        exit(0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我的"
        self.vLogo.backgroundColor = BaseColor.statusBarColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
