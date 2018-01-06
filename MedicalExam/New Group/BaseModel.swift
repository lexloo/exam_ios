//
//  BaseModel.swift
//  MedicalExam
//
//  Created by 黄奇 on 06/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import RealmSwift

class BaseModel: Object {
    override var description: String {
        let clazz: Object.Type = type(of: self)
        
        return ""
    }
}
