//
//  SingleSelectorViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 28/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit

class SingleSelectorViewController: BaseUIViewController {
    private lazy var tableView: UITableView? = {
        let tempTableView = UITableView(frame: self.view.bounds, style: UITableViewStyle.plain)
        tempTableView.delegate = self
        tempTableView.dataSource = self
        tempTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        //去除多余的空白行
        tempTableView.tableFooterView = UIView()
        
        return tempTableView
    }()
    
    private var items: [SelectItem]?
    var dataSource: SelectDataSource? {
        didSet {
            dataSource?.queryItemData {
                result in
                self.items = result
                self.view.addSubview(self.tableView!)
            }
        }
    }
    
    var deselectRow = true
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func selectItem(_ item: SelectItem) {
        // subclass implement
    }
}

extension SingleSelectorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "id")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "id")
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items![indexPath.row]
        
        if deselectRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        self.selectItem(item)
    }
}
