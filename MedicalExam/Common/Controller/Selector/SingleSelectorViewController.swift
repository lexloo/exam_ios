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
        let bounds = self.view.bounds
        let tempTableView = UITableView(frame: CGRect(x: 0.0, y: 60.0, width: bounds.width, height: bounds.height - 60.0), style: UITableViewStyle.plain)
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
    
    var topView: TopNaviView?
    var deselectRow = true
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
