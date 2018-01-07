//
//  QuestionBankController.swift
//  MedicalExam
//
//  Created by 黄奇 on 24/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//

import UIKit

class QuestionBankViewController: UIViewController {
    private lazy var dataSource: [SectionModel]? = nil
    private var lastActiveSection: Int?
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "题库"
        self.view.backgroundColor = UIColor.brown
        
        initViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initViews() {
        initTableView()
    }
}

extension QuestionBankViewController: UITableViewDataSource {
    func initTableView() {
        SectionModel.loadSections {
            (models) in self.dataSource = models
        }
        
        self.view.addSubview(tableView)
    }
    
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
}

extension QuestionBankViewController: UITableViewDelegate {
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
        
//        let alert = UIAlertController(title: "", message: subjectName! + ":" + chapterName!, preferredStyle: .alert)
//        self.present(alert, animated: true, completion: nil)
    }
}
