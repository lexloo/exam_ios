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
    @IBOutlet var tbProp: UITableView!
    
    @IBAction func exitClick(_ sender: UIButton) {
        exit(0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "我的"
        
        vLogo.bounds = CGRect(x: 0, y: 0, width: view.bounds.width, height: 160)
        vLogo.backgroundColor = BaseColor.statusBarColor
        self.tbProp.tableFooterView = UIView();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
