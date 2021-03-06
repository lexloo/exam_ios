//
//  Subject.swift
//  MedicalExam
//
//  Created by 黄奇 on 07/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import RealmSwift
import SwiftyJSON

class Subject: BaseItem {
    @objc dynamic var categoryGuid: String?
    
    func mapping(_ json: JSON) {
        self.guid = json["guid"].string
        self.name = json["name"].string
        self.categoryGuid = json["categoryGuid"].string
    }
}
