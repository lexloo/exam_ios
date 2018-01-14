//
//  ChapterQuestionDo.swift
//  MedicalExam
//
//  Created by 黄奇 on 14/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import RealmSwift
import SwiftyJSON

class ChapterQuestionDo: Object {
    @objc dynamic var questionGuid: String?
    @objc dynamic var chapterGuid: String?
    @objc dynamic var answer: String?
    @objc dynamic var result: String?
    
    override static func primaryKey() -> String {
        return "questionGuid"
    }
    
    func mapping(_ json: JSON) {
        self.questionGuid = json["questionGuid"].string
        self.chapterGuid = json["chapterGuid"].string
        self.answer = json["answer"].string
        self.result = json["result"].string
    }
}
