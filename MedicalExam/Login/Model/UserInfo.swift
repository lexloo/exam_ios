//
//  UserInfo.swift
//  MedicalExam
//
//  Created by 黄奇 on 06/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class UserInfo: Object  {
    @objc dynamic var mobile: String?
    @objc dynamic var guid: String?
    @objc dynamic var name: String?
    @objc dynamic var examKind: String?
    @objc dynamic var examCategory: String?
    @objc dynamic var password: String?
    @objc dynamic var modifyTime: Date?
    @objc var avator: String?
    
    override static func primaryKey() -> String {
        return "mobile"
    }
    
    func mapping(_ json: JSON) {
        self.mobile = json["mobile"].string
        self.guid = json["guid"].string
        self.name = json["name"].string
        self.examKind = json["examKind"].string
        self.examCategory = json["examCategory"].string
        self.password = json["password"].string
        
        let timeStamp = json["modifyTime"].int
        let timeInterval = TimeInterval(timeStamp!)
        self.modifyTime = Date(timeIntervalSince1970: timeInterval)
    }
    
    func copyFrom(_ userInfo: UserInfo) {
        self.mobile = userInfo.mobile
        self.guid = userInfo.guid
        self.name = userInfo.name
        self.examKind = userInfo.examKind
        self.examCategory = userInfo.examCategory
        self.password = userInfo.password
    }
//    override static func indexedProperties() -> [String] {
//        return ["mobile"]
//    }
}
