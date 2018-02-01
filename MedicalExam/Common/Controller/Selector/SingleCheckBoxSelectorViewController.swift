//
//  SingleCheckBoxSelectorViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 28/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import UIKit

class SingleCheckBoxSelectorViewController: UIViewController {
    private lazy var tableView: UITableView? = {
        let bounds = self.view.bounds
        let tempTableView = UITableView(frame: CGRect(x: 0.0, y: 60.0, width: bounds.width, height: bounds.height - 60.0), style: UITableViewStyle.plain)
        tempTableView.dataSource = self
        tempTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        //去除多余的空白行
        tempTableView.tableFooterView = UIView()
        
        return tempTableView
    }()
    
    var items: [SelectItem]?
    var dataSource: SelectDataSource? {
        didSet {
            dataSource?.queryItemData {
                result in
                self.items = result
                self.view.addSubview(self.tableView!)
            }
        }
    }
    
    var topView: TopNaviView?
    override var title: String? {
        didSet {
            self.topView?.title = title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        topView = TopNaviView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.bounds.width, height: 60.0))
        
        self.view.addSubview(topView!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getSelectItem() -> SelectItem? {
        let indexPath = self.tableView?.indexPathForSelectedRow
        
        if let p = indexPath {
            return self.items?[p.row]
        } else {
            return nil
        }
    }
}

extension SingleCheckBoxSelectorViewController: UITableViewDataSource {
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
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
}

