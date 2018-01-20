//
//  SectionModel.swift
//  MedicalExam
//
//  Created by 黄奇 on 24/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//
class SectionModel {
    var title: String?
    var subjectGuid: String?
    var isExpanded: Bool? = false
    var cellModels: [CellModel] = []
    var isLoaded: Bool? = false
    
    func loadCellModels() {
        self.isLoaded = true
        var cellModels = [CellModel]()
        
        let chapters = RealmUtil.selectByFilterString(Chapter.self, filter: "subjectGuid = '\(self.subjectGuid!)'");
        for chapter in chapters {
            let cellModel = CellModel()
            cellModel.title = chapter.name
            cellModel.guid = chapter.guid
            
            cellModels.append(cellModel)
        }
        
        self.cellModels = cellModels
    }
    
    class func loadSections(finish: ([SectionModel]) -> ()) {
        var array = [SectionModel]()
        let userInfo = Global.userInfo
        let subjects = RealmUtil.selectByFilterString(Subject.self, filter: "categoryGuid = '\(userInfo.examCategory!)'");
        for subject in subjects {
            let s = SectionModel()
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
        let subjects = RealmUtil.selectByFilterString(Subject.self, filter: "categoryGuid = '\(userInfo.examCategory!)'");
        for subject in subjects {
            let s = SectionModel()
            s.title = subject.name
            s.subjectGuid = subject.guid
            s.isExpanded = false
            
            array.append(s)
        }
        
        finish(array)
    }
}
