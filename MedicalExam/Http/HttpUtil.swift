//
//  HttpUtil.swift
//  MedicalExam
//
//  Created by 黄奇 on 06/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class HttpUtil {
    static let URL_PREFIX = "http://192.168.1.6/question-bank/v1/"

    static func post(_ serviceURL: String, parameters: Parameters?, completionHandler handler: @escaping (JSON) -> Void) {
        Alamofire.request(URL_PREFIX + serviceURL, method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.default).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                handler(json["message"])
            case .failure(let error):
                print(error)
            }
        }
    }
}
