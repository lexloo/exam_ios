//
//  WKWebViewCallback.swift
//  MedicalExam
//
//  Created by 黄奇 on 20/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import SwiftyJSON

protocol WKWebViewCallback {
    func exec(funcName: String, data: JSON)
}
