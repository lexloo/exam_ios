//
//  UIQuestionBankBaseViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 20/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit

class UIQuestionBankBaseViewController: UIViewController {
    lazy var dataSource: [SectionModel]? = nil
    var lastActiveSection: Int?
    var type: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = BaseColor.statusBarColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIQuestionBankBaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "id") as? TableViewCell
        if cell == nil {
            cell = TableViewCell.init(style: UITableViewCellStyle.value1, reuseIdentifier: "id")
        }
        
        cell?.cellModel = dataSource![indexPath.section].cellModels[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionModel = dataSource![section]
        if sectionModel.isExpanded != false {
            return sectionModel.cellModels.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
}

extension UIQuestionBankBaseViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (dataSource?.count)!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "id") as? HeaderView
        if headerView == nil {
            headerView = HeaderView.init(reuseIdentifier: "id")
        }
        
        headerView?.sectionModel = dataSource![section]
        headerView?.expandCallBack = {
            (isExpanded: Bool) -> Void in
            if isExpanded {
                if self.lastActiveSection != nil && self.lastActiveSection != section {
                    self.dataSource![self.lastActiveSection!].isExpanded = false
                    tableView.reloadSections([section, self.lastActiveSection!], with: UITableViewRowAnimation.fade)
                } else {
                    tableView.reloadSections([section], with: UITableViewRowAnimation.fade)
                }
                
                self.lastActiveSection = section
            } else {
                tableView.reloadSections([section], with: UITableViewRowAnimation.fade)
            }
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = self.dataSource![indexPath.section]
        let cell = section.cellModels[indexPath.row]
        
        let subjectName = section.title
        let chapterName = cell.title
        let chapterGuid = cell.guid
        
        let loginStoryBoard = UIStoryboard(name: "UILogin", bundle: nil)
        let selectQuestionVC = loginStoryBoard.instantiateViewController(withIdentifier: "SelectQuestionVC") as! SelectQuestionViewController
        selectQuestionVC.subjectName = subjectName
        selectQuestionVC.chapterName = chapterName
        selectQuestionVC.chapterGuid = chapterGuid
        selectQuestionVC.type = type
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.present(selectQuestionVC, animated: true, completion: nil)
    }
}
