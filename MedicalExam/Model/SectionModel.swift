//
//  SectionModel.swift
//  MedicalExam
//
//  Created by 黄奇 on 24/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//
class SectionModel {
    var title: String?
    var isExpanded: Bool? = false
    var cellModels: [CellModel] = []
    var isLoaded: Bool? = false
    
    func loadCellModels() {
        var cellModels = [CellModel]()
        
        for j in 0..<6 {
            let cellModel = CellModel()
            cellModel.title = "Cell \(j)"
            
            cellModels.append(cellModel)
        }
        
        self.isLoaded = true
        self.cellModels = cellModels
    }
    
    class func loadSections(finish: ([SectionModel]) -> ()) {
        var array = [SectionModel]()
        for i in 0..<10 {
            let sectionModel = SectionModel()
            sectionModel.isExpanded = false
            sectionModel.title = "Section \(i)"
            
            array.append(sectionModel)
        }
        
        finish(array)
    }
}
