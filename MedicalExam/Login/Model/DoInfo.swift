//
//  ChapterQuestionDo.swift
//  MedicalExam
//
//  Created by 黄奇 on 14/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import RealmSwift
import SwiftyJSON

class DoInfo: Object {
    @objc dynamic var answer: String?
    @objc dynamic var result: String?
    
    func mapping(_ json: JSON) {
        self.answer = json["answer"].string
        self.result = json["result"].string
    }
}
