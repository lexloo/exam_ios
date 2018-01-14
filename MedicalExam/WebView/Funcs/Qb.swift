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
            getChapterQuestion(nvWebView:nvWebView, params: params, callbackId: callbackId)
        } else if (funcName == "startDoQuestion") {
            startDoQuestion(nvWebView:nvWebView, params: params, callbackId: callbackId)
        }
    }
    
    static func getChapterQuestion(nvWebView: NvWKWebView, params: JSON, callbackId: String?) {
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
        let doQuestionViewController = DoQuestionViewController();
        
        nvWebView.uiViewController?.present(doQuestionViewController, animated: true, completion: nil)
//        let type = params["type"].string
//        let chapterGuid = params["chapterGuid"].string!
//        print("chapter:" + chapterGuid)
//
//        if type == nil {
//            let qs = RealmUtil.selectByFilterString(ChapterQuestions.self, filter: "chapterGuid =='\(chapterGuid)'")
//
//            var arr = [[String: Any?]]();
//            for i in 0 ..< qs.count {
//                arr.append(["no": qs[i].index, "guid": qs[i].guid, "status": 1])
//            }
//
//            let result = JSON(arr)
//            nvWebView.sendCallback(callbackId: callbackId, result: result)
//        }
    }
}
