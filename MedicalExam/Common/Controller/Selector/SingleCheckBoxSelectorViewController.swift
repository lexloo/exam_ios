//
//  SingleCheckBoxSelectorViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 28/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import UIKit

class SingleCheckBoxSelectorViewController: BaseUIViewController {
    private lazy var tableView: UITableView? = {
        let tempTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

