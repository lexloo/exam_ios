//
//  SingleSelectorViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 28/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit

class SingleSelectorViewController: UIViewController {
    private lazy var tableView: UITableView? = {
        let bounds = self.view.bounds
        let tempTableView = UITableView(frame: CGRect(x: 0.0, y: 60.0, width: bounds.width, height: bounds.height - 60.0), style: UITableViewStyle.plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        //去除多余的空白行
        tempTableView.tableFooterView = UIView()
        
        return tempTableView
    }()
    
    private lazy var items: [SelectItem]? = {
        return self.dataSource?.getItemData()
    }()
    
    var dataSource: SelectDataSource? {
        didSet {
            self.view.addSubview(self.tableView!)
        }
    }
    
    var topView: TopNaviView?
    override var title: String? {
        didSet {
            self.topView?.title = title
        }
    }
    
    var fnBack: ()-> Void
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        topView = TopNaviView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: 60.0))
        topView?.btnLeft?.addTarget(self, action: #selector(tappedReturn), for: .touchUpInside)
        self.view.addSubview(topView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func tappedReturn() {
        if fnBack != nil {
            fnBack()
        }
    }
}

extension SingleSelectorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "id")
        if cell == nil {
            cell = SingleSelectTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "id")
            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
        cell?.textLabel?.text = items?[indexPath.row].description
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.items?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
}

extension SingleSelectorViewController: UITableViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return (dataSource?.count)!
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        var headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "id") as? HeaderView
//        if headerView == nil {
//            headerView = HeaderView.init(reuseIdentifier: "id")
//        }
//
//        headerView?.sectionModel = dataSource![section]
//        headerView?.expandCallBack = {
//            (isExpanded: Bool) -> Void in
//            if isExpanded {
//                if self.lastActiveSection != nil && self.lastActiveSection != section {
//                    self.dataSource![self.lastActiveSection!].isExpanded = false
//                    tableView.reloadSections([section, self.lastActiveSection!], with: UITableViewRowAnimation.fade)
//                } else {
//                    tableView.reloadSections([section], with: UITableViewRowAnimation.fade)
//                }
//
//                self.lastActiveSection = section
//            } else {
//                tableView.reloadSections([section], with: UITableViewRowAnimation.fade)
//            }
//        }
//
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let section = self.dataSource![indexPath.section]
//        let cell = section.cellModels[indexPath.row]
//
//        let subjectName = section.title
//        let chapterName = cell.title
//        let chapterGuid = cell.guid
//
//        let loginStoryBoard = UIStoryboard(name: "UILogin", bundle: nil)
//        let selectQuestionVC = loginStoryBoard.instantiateViewController(withIdentifier: "SelectQuestionVC") as! SelectQuestionViewController
//        selectQuestionVC.subjectName = subjectName
//        selectQuestionVC.chapterName = chapterName
//        selectQuestionVC.chapterGuid = chapterGuid
//        selectQuestionVC.type = type
//
//        tableView.deselectRow(at: indexPath, animated: true)
//        self.present(selectQuestionVC, animated: true, completion: nil)
        //tableView.deselectRow(at: indexPath, animated: true)
    }
}
