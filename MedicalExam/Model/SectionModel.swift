//
//  SectionModel.swift
//  MedicalExam
//
//  Created by 黄奇 on 24/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//
import RealmSwift

class SectionModel {
    var title: String?
    var subjectGuid: String?
    var type: String?
    var isExpanded: Bool? = false
    var cellModels: [CellModel] = []
    var isLoaded: Bool? = false
    
    func loadCellModels() {
        self.isLoaded = true
        var cellModels = [CellModel]()
        //var chapters: Results<Chapter>
        
        if self.type == "notes" || self.type == "liked" || self.type == "error" {
            let guidArr = SectionModel.getChaptersMap(type!)
            let chapters = RealmUtil.selectByFilterString(Chapter.self, filter: "subjectGuid = '\(self.subjectGuid!)'");
            
            for chapter in chapters {
                if guidArr.contains(chapter.guid!) {
                    let cellModel = CellModel()
                    cellModel.title = chapter.name
                    cellModel.guid = chapter.guid
                    
                    cellModels.append(cellModel)
                }
            }
        } else {
            let chapters = RealmUtil.selectByFilterString(Chapter.self, filter: "subjectGuid = '\(self.subjectGuid!)'");
            
            for chapter in chapters {
                let cellModel = CellModel()
                cellModel.title = chapter.name
                cellModel.guid = chapter.guid
                
                cellModels.append(cellModel)
            }
        }

        self.cellModels = cellModels
    }
    
    class func loadSections(finish: ([SectionModel]) -> ()) {
        var array = [SectionModel]()
        let userInfo = Global.userInfo
        let subjects = RealmUtil.selectByFilterString(Subject.self, filter: "categoryGuid = '\(userInfo.examCategory!)'");
        for subject in subjects {
            let s = SectionModel()
            s.type = "all"
            s.title = subject.name
            s.subjectGuid = subject.guid
            s.isExpanded = false
            
            array.append(s)
        }
        
        finish(array)
    }
    
    class func loadSectionsWithType(_ type: String, finish: ([SectionModel]) -> ()) {
        var array = [SectionModel]()
        let userInfo = Global.userInfo
        
        let subjectMap = getSubjectMap(type)
        let subjects = RealmUtil.selectByFilterString(Subject.self, filter: "categoryGuid = '\(userInfo.examCategory!)'");
        for subject in subjects {
            if subjectMap.contains(subject.guid!) {
                let s = SectionModel()
                s.type = type
                s.title = subject.name
                s.subjectGuid = subject.guid
                s.isExpanded = false
                
                array.append(s)
            }
        }
        
        finish(array)
    }
    
    class func getSubjectMap(_ type: String) -> [String] {
        var filter: String
        if type == "notes" {
            filter = "notes != nil"
        } else if type == "liked" {
            filter = "likes != nil"
        } else {
            filter = "doinfo != nil"
        }
        
        let questions = RealmUtil.selectByFilterString(ChapterQuestions.self, filter: filter)
        var subjectGuidArr = [String]()
        
        for q in questions {
            if !subjectGuidArr.contains(q.subjectGuid!) {
                subjectGuidArr.append(q.subjectGuid!)
            }
        }
        
        return subjectGuidArr
    }
    
    class func getChaptersMap(_ type: String) -> [String] {
        var filter: String
        if type == "notes" {
            filter = "notes != nil"
        } else if type == "liked" {
            filter = "likes != nil"
        } else {
            filter = "doinfo != nil"
        }
        
        print(filter)
        
        let questions = RealmUtil.selectByFilterString(ChapterQuestions.self, filter: filter)
        var chapterGuidArr = [String]()
        
        for q in questions {
            if !chapterGuidArr.contains(q.chapterGuid!) {
                chapterGuidArr.append(q.chapterGuid!)
            }
        }
        
        return chapterGuidArr
    }
}
