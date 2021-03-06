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
    //static let URL_PREFIX = "http://192.168.1.6/question-bank/v1/"
    static let URL_PREFIX = "http://121.43.96.235:7001/question-bank/v1/"
    
    static func postReturnResult(_ serviceURL: String, parameters: Parameters?, viewController: UIViewController, completionHandler handler: @escaping (JSON) -> Void) {
        Alamofire.request(URL_PREFIX + serviceURL, method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.default).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json["code"].int == 1 {
                    MessageUtils.alert(viewController: viewController, message: json["message"].string!)
                } else {
                   handler(json["message"])
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func postReturnData(_ serviceURL: String, parameters: Parameters?, completionHandler handler: @escaping (JSON) -> Void) {
        Alamofire.request(URL_PREFIX + serviceURL, method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.default).responseJSON {
            response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)

                handler(json)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func postReturnString(_ serviceURL: String, parameters: Parameters?, completionHandler handler: @escaping (String) -> Void) {
        Alamofire.request(URL_PREFIX + serviceURL, method: HTTPMethod.post, parameters: parameters, encoding: URLEncoding.default).responseString {
            response in
            switch response.result {
            case .success(let value):
                handler(value)
            case .failure(let error):
                print(error)
            }
        }
    }
}
