//
//  TypeQuestionViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 20/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import Foundation
import UIKit

class TypeQuestionViewController: UIQuestionBankBaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch self.type {
        case "liked"?:
            txtTitle.text = "收藏"
        case "error"?:
            txtTitle.text = "错题"
        case "notes"?:
            txtTitle.text = "笔记"
        default:
            txtTitle.text = "ERROR"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func returnClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
