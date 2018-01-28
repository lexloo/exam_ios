//
//  SelectItemModel.swift
//  MedicalExam
//
//  Created by 黄奇 on 28/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
class SelectItem {
    var guid: String?;
    var name: String?;
    
    init(guid: String?, name: String?) {
        self.guid = guid
        self.name = name
    }
    
    override var description: String {
        return self.name
    }
}
