//
//  WebViewModuleFuncs.swift
//  MedicalExam
//
//  Created by 黄奇 on 14/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import Foundation
import SwiftyJSON

class WebViewModuleFuncs {
    static func exec(module: String, funcName: String, data: JSON) {
        if module == "qb" {
            Qb.exec(funcName: funcName, data: data)
        }
    }
}
