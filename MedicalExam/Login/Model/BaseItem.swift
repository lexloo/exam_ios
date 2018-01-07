//
//  BaseItem.swift
//  MedicalExam
//
//  Created by 黄奇 on 07/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import RealmSwift

class BaseItem: Object {
    @objc dynamic var guid: String?
    @objc dynamic var name: String?
    
    override static func primaryKey() -> String {
        return "guid"
    }
}
