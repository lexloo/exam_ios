//
//  SingleSelectTableViewCell.swift
//  MedicalExam
//
//  Created by 黄奇 on 28/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit

class SingleSelectTableViewCell: UITableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            imageView?.image = UIImage(named: "check_circle")
        } else {
            imageView?.image = UIImage(named: "uncheck_circle")
        }
    }
}
