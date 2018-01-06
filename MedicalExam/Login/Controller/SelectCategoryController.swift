//
//  SelectCategoryController.swift
//  MedicalExam
//
//  Created by 黄奇 on 06/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit
import Foundation

class SelectCategoryController: UIViewController {
    @IBOutlet weak var naviTopView: NaviTopView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviTopView.btnReturn.addTarget(self, action: #selector(close), for: UIControlEvents.touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
