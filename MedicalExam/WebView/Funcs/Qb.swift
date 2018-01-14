//
//  Qb.swift
//  MedicalExam
//
//  Created by 黄奇 on 14/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import Foundation
import SwiftyJSON

class Qb {
    static func exec(nvWebView: NvWKWebView, funcName: String, data: JSON) {
        let params = data["params"]
        let callbackId = data["callbackId"].string
        
        if funcName == "getChapterQuestion" {
            getChapterQuestions(nvWebView:nvWebView, params: params, callbackId: callbackId)
        } else if (funcName == "startDoQuestion") {
            startDoQuestion(nvWebView:nvWebView, params: params, callbackId: callbackId)
        } else if (funcName == "getDoQuestion") {
            getDoQuestion(nvWebView: nvWebView, params: params, callbackId: callbackId)
        } else if (funcName == "getCommentCount") {
            getCommentCount(nvWebView: nvWebView, params: params, callbackId: callbackId)
        } else if (funcName == "saveDoQuestion") {
            saveDoQuestion(nvWebView: nvWebView, params: params, callbackId: callbackId)
        }
    }
    
    static func getChapterQuestions(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
        let type = params["type"].string
        let chapterGuid = params["chapterGuid"].string!
        
        
        let doInfo = RealmUtil.selectByFilterString(ChapterQuestionDo.self, filter: "chapterGuid == '\(chapterGuid)'")
        var doInfoMap = [String: String]()
        for item in doInfo {
            doInfoMap[item.questionGuid!] = item.result
        }
        
        if type == nil {
            let qs = RealmUtil.selectByFilterString(ChapterQuestions.self, filter: "chapterGuid =='\(chapterGuid)'")
            
            var arr = [[String: Any?]]();
            for i in 0 ..< qs.count {
                arr.append(["no": qs[i].index, "guid": qs[i].guid, "status": doInfoMap[qs[i].guid!]])
            }
            
            let result = JSON(arr)
            nvWebView.sendCallback(callbackId: callbackId!, result: result)
        }
    }
    
    static func startDoQuestion(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
        let loginStoryBoard = UIStoryboard(name: "UILogin", bundle: nil)
        let doQuestionVC = loginStoryBoard.instantiateViewController(withIdentifier: "DoQuestionVC") as! DoQuestionViewController
        
        doQuestionVC.subjectName = params["subjectName"].string
        doQuestionVC.chapterName = params["chapterName"].string
        doQuestionVC.chapterGuid = params["chapterGuid"].string
        doQuestionVC.questionGuid = params["questionGuid"].string
        doQuestionVC.index = params["index"].string
        doQuestionVC.type = params["type"].string
        
        nvWebView.uiViewController?.present(doQuestionVC, animated: true, completion: nil)
    }

    static func getDoQuestion(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
        let questionGuid = params["questionGuid"].string!
        
        let question = RealmUtil.select(ChapterQuestions.self, forPrimaryKey: questionGuid)
        let questionDo = RealmUtil.selectByFilterString(ChapterQuestionDo.self, filter: "questionGuid == '\(questionGuid)'").first
        
        var result = JSON.init(parseJSON: question.data!);
        
        if questionDo != nil {
            if questionDo?.result != nil {
                result["status"].int = Int((questionDo?.result)!)
                result["select"].string = questionDo?.answer
            } else {
                result["status"].int = 0
            }
        } else {
            result["status"].int = 0
        }
        
        nvWebView.sendCallback(callbackId: callbackId!, result: result)
    }
    
    static func getCommentCount(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
        let parameters = ["question_guid": params["questionGuid"].string!]
        HttpUtil.postReturnString("question/comment_count", parameters: parameters) {
            result in
            
            let json = JSON(["count": result]);
            nvWebView.sendCallback(callbackId: callbackId!, result: json)
        }
    }
    
    static func saveDoQuestion(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
        let value = ChapterQuestionDo()
        value.questionGuid = params["questionGuid"].string
        value.chapterGuid = params["chapterGuid"].string
        value.answer = params["answer"].string
        value.result = params["result"].string
        
        RealmUtil.addCanUpdate(value)
        
        let parameters = [
            "user_guid": Global.userInfo.guid!,
            "question_guid": value.questionGuid!,
            "chapter_guid": value.chapterGuid!,
            "answer": value.answer!,
            "result": value.result!]
        HttpUtil.postReturnString("question/do_info/set", parameters: parameters) {
            result in
            nvWebView.reloadHtml()
            //nvWebView.sendCallback(callbackId: callbackId!, result: JSON())
        }
    }
}
