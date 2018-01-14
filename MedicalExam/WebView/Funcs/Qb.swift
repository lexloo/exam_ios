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
        let callbackId = data["callbackId"].string!
        
        if funcName == "getChapterQuestion" {
            getChapterQuestion(nvWebView:nvWebView, params: params, callbackId: callbackId)
        }
    }
    
    static func getChapterQuestion(nvWebView: NvWKWebView, params: JSON, callbackId: String) {
        var json = JSON();
        json["a"].string = "fafaf"
        
        nvWebView.sendCallback(callbackId: callbackId, result: json)
    }
}
