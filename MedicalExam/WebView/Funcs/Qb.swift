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
        }
    }
    
    static func getChapterQuestions(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
        let type = params["type"].string
        let chapterGuid = params["chapterGuid"].string!
        print("chapter:" + chapterGuid)
        
        if type == nil {
            let qs = RealmUtil.selectByFilterString(ChapterQuestions.self, filter: "chapterGuid =='\(chapterGuid)'")
            
            var arr = [[String: Any?]]();
            for i in 0 ..< qs.count {
                arr.append(["no": qs[i].index, "guid": qs[i].guid, "status": 1])
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
        
        let result = JSON.init(parseJSON: question.data!);
        nvWebView.sendCallback(callbackId: callbackId!, result: result)
    }
    
    static func getCommentCount(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
        let parameters = ["question_guid": params["questionGuid"].string!]
        HttpUtil.postReturnString("question/comment_count", parameters: parameters) {
            result in
            
            let json = JSON(["count": result]);
            print(json)
            nvWebView.sendCallback(callbackId: callbackId!, result: json)
        }
    }
}
