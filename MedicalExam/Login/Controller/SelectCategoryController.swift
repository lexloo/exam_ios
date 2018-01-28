//
//  SelectCategoryViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 28/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import UIKit
import Foundation

class SelectCategoryController: SingleCheckBoxSelectorViewController {
    var kindGuid: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "选择考试分类"
        self.dataSource = self
        self.topView?.rightButtonTitle = "保存"
        self.topView?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setCategory(categoryGuid: String) {
        let userInfo = UserInfo()
        userInfo.copyFrom(Global.userInfo)
        userInfo.examKind = self.kindGuid
        userInfo.examCategory = categoryGuid
        Global.userInfo.copyFrom(userInfo)
        
        let parameters = ["guid": userInfo.guid!, "kind": userInfo.examKind!, "category": userInfo.examCategory!]
        HttpUtil.postReturnString("user/kind_category", parameters: parameters) {
            result in
            if "SUCCESS" == result {
                self.refreshData(userInfo: userInfo)
            }
        }
    }
    
    func refreshData(userInfo: UserInfo) {
        RealmUtil.addCanUpdate(userInfo)
        
        RealmUtil.delete(RealmUtil.selectAll(ChapterQuestions.self))
        RealmUtil.delete(RealmUtil.selectAll(Chapter.self))
        RealmUtil.delete(RealmUtil.selectAll(Subject.self))
        
        let p1 = ["category_guid": userInfo.examCategory!]
        HttpUtil.postReturnData("list/subject", parameters: p1) {
            json in
            var subjects = [Subject]()
            for (_, item) in json {
                let subject = Subject()
                subject.mapping(item)
                subjects.append(subject)
            }
            RealmUtil.addListData(subjects)
        }
        
        let p2 = ["category_guid": userInfo.examCategory!]
        HttpUtil.postReturnData("list/category_chapter", parameters: p2) {
            json in
            var chapters = [Chapter]()
            for (_, item) in json {
                let chapter = Chapter()
                chapter.mapping(item)
                chapters.append(chapter)
            }
            RealmUtil.addListData(chapters)
        }
        
        let p3 = ["category_guid": userInfo.examCategory!]
        HttpUtil.postReturnData("question/category/get", parameters: p3) {
            json in
            var questions = [ChapterQuestions]()
            for (_, item) in json {
                let question = ChapterQuestions()
                question.mapping(item)
                questions.append(question)
            }
            RealmUtil.addListData(questions)
        }
    }
}

extension SelectCategoryController: TopNaviViewDelegate {
    func leftClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func rightClick() {
        if let select = self.getSelectItem() {
            setCategory(categoryGuid: select.guid!)
        } else {
            MessageUtils.alert(viewController: self, message: "请选择考试分类")
        }
    }
}

extension SelectCategoryController: SelectDataSource {
    func queryItemData(_ cb: @escaping ([SelectItem]?) -> Void) {
        let p = ["kind_guid": self.kindGuid!]
        HttpUtil.postReturnData("list/catagory", parameters: p) {
            json in
            var items = [SelectItem]()
            
            for (_, item) in json {
                items.append(SelectItem(guid: item["guid"].string, name: item["name"].string))
            }
            
            cb(items)
        }
    }
}
