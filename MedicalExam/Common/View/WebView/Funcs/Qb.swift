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
        print(funcName);
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
        } else if (funcName == "getDoQuestionInfo") {
            getDoQuestionInfo(nvWebView: nvWebView, params: params, callbackId: callbackId)
        } else if (funcName == "showComments") {
            showComments(nvWebView: nvWebView, params: params, callbackId: callbackId)
        } else if (funcName == "getComments") {
            getComments(nvWebView: nvWebView, params: params, callbackId: callbackId)
        }
    }
    
    static func getChapterQuestions(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
        let type = params["type"].string
        let chapterGuid = params["chapterGuid"].string!
        
        var filter = QuestionBankFilterUtils.getTypeFilter(type!)
        if filter != "" {
            filter = " and \(filter)"
        }
        
        let qs = RealmUtil.selectByFilterString(ChapterQuestions.self, filter: "chapterGuid =='\(chapterGuid)' \(filter)")

        var arr = [[String: Any?]]();
        for i in 0 ..< qs.count {
            var status: Int = 0
            if qs[i].doinfo?.result != nil {
                status = Int((qs[i].doinfo?.result)!)!
            }
            arr.append(["no": qs[i].index, "guid": qs[i].guid, "status": status])
        }
        
        let result = JSON(arr)
        nvWebView.sendCallback(callbackId: callbackId!, result: result)
    }
    
    static func startDoQuestion(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
        let loginStoryBoard = UIStoryboard(name: "QuestionBank", bundle: nil)
        let doQuestionVC = loginStoryBoard.instantiateViewController(withIdentifier: "DoQuestionVC") as! DoQuestionViewController
        
        doQuestionVC.subjectName = params["subjectName"].string
        doQuestionVC.chapterName = params["chapterName"].string
        doQuestionVC.chapterGuid = params["chapterGuid"].string
        doQuestionVC.questionGuid = params["questionGuid"].string
        doQuestionVC.index = params["index"].string
        doQuestionVC.type = params["type"].string
        
        nvWebView.uiViewController?.navigationController?.pushViewController(doQuestionVC, animated: true)
    }

    static func getDoQuestion(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
        let questionGuid = params["questionGuid"].string!
        
        let question = RealmUtil.select(ChapterQuestions.self, forPrimaryKey: questionGuid)
        
        var result = JSON.init(parseJSON: question.data!);

        result["index"].string = question.index;
        if question.doinfo == nil {
            result["status"].int = 0
        } else {
            result["status"].int = Int((question.doinfo?.result)!)
            result["select"].string = question.doinfo?.answer
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
        let questionGuid = params["questionGuid"].string!
        let question = RealmUtil.select(ChapterQuestions.self, forPrimaryKey: questionGuid)
        
        var doinfo = question.doinfo
        if doinfo == nil {
            doinfo = DoInfo()
            
            doinfo?.answer = params["answer"].string
            doinfo?.result = params["result"].string
            
            RealmUtil.updateField {
                question.doinfo = doinfo;
            }
        } else {
            RealmUtil.updateField {
                question.doinfo?.answer = params["answer"].string
                question.doinfo?.result = params["result"].string
            }
        }
        
        let parameters: [String: String] = [
            "user_guid": Global.userInfo.guid!,
            "question_guid": question.guid!,
            "chapter_guid": question.chapterGuid!,
            "answer": (doinfo?.answer)!,
            "result": (doinfo?.result)!]
        HttpUtil.postReturnString("question/do_info/set", parameters: parameters) {
            result in
            nvWebView.sendCallback(callbackId: callbackId!, result: JSON())
        }
    }
    
    static func getDoQuestionInfo(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
        let parameters = ["question_guid": params["questionGuid"].string!, "user_guid": Global.userInfo.guid!]
        HttpUtil.postReturnString("question/do_info/get", parameters: parameters) {
            result in
            
            let json = JSON.init(parseJSON: result);
            print(json);
            nvWebView.sendCallback(callbackId: callbackId!, result: json)
        }
    }
    
    static func showComments(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
        let loginStoryBoard = UIStoryboard(name: "QuestionBank", bundle: nil)
        let commentsVC = loginStoryBoard.instantiateViewController(withIdentifier: "CommentsVC") as! CommentsViewController
        
        commentsVC.questionGuid = params["questionGuid"].string
        nvWebView.uiViewController?.navigationController?.pushViewController(commentsVC, animated: true)
    }
    
    static func getComments(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
        let parameters = ["question_guid": params["questionGuid"].string!, "page": "1"]
        HttpUtil.postReturnData("question/list_comment", parameters: parameters) {
            result in
            nvWebView.sendCallback(callbackId: callbackId!, result: result)
        }
    }
}
