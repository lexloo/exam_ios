//
//  QuestionBankFilterUtils.swift
//  MedicalExam
//
//  Created by 黄奇 on 20/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
class QuestionBankFilterUtils {
    static func getTypeFilter(_ type: String) -> String {
        var filter: String = ""
        
        if type == "notes" {
            filter = "notes != nil"
        } else if type == "liked" {
            filter = "likes != nil"
        } else if type == "error" {
            filter = "doinfo != nil"
        }
        
        return filter
    }
}
