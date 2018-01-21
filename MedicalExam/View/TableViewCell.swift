//
//  TableViewCell.swift
//  MedicalExam
//
//  Created by 黄奇 on 24/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//
import UIKit

class TableViewCell: UITableViewCell {
    var cellModel: CellModel? {
        didSet {
            textLabel?.text = cellModel?.title
            accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
