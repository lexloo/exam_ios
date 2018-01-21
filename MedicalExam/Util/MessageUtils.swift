//
//  MessageUtils.swift
//  MedicalExam
//
//  Created by 黄奇 on 19/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit
import WebKit

class MessageUtils {
    static func alert(viewController: UIViewController, message: String) -> Void {
        let alert = UIAlertController(title: "信息", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))

        viewController.present(alert, animated: true, completion: nil)
    }
}
