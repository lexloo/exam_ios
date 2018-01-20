//
//  ChapterQuestions.swift
//  MedicalExam
//
//  Created by 黄奇 on 07/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import RealmSwift
import SwiftyJSON

class ChapterQuestions: Object {
    @objc dynamic var guid: String?
    @objc dynamic var index: String?
    @objc dynamic var categoryGuid: String?
    @objc dynamic var subjectGuid: String?
    @objc dynamic var chapterGuid: String?
    @objc dynamic var data: String?
    
    @objc dynamic var notes: Notes?
    @objc dynamic var likes: Likes?
    @objc dynamic var doinfo: DoInfo?

    override static func primaryKey() -> String {
        return "guid"
    }
    
    func mapping(_ json: JSON) {
        self.guid = json["guid"].string
        self.index = json["index"].string
        self.categoryGuid = json["categoryGuid"].string
        self.subjectGuid = json["subjectGuid"].string
        self.chapterGuid = json["chapterGuid"].string
        self.data = json["data"].string
    }
}
