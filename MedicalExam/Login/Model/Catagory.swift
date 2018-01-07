//
//  Category.swift
//  MedicalExam
//
//  Created by 黄奇 on 06/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import SwiftyJSON

class Catagory {
    var guid: String?
    var name: String?
    var kindGuid: String?
    
    func mapping(_ json: JSON) {
        self.guid = json["guid"].string
        self.name = json["name"].string
        self.kindGuid = json["kindGuid"].string
    }
}
