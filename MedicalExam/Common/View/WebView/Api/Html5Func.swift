//
//  Html5Func.swift
//  MedicalExam
//
//  Created by 黄奇 on 04/02/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import UIKit

class Html5Func: NSObject {
    override required init() {
    }
    func call() {
        print("base")
    }
}

class Test: Html5Func {
    override func call() {
        print("Test")
    }
}

class Html5FuncFactory {
    static func getClass(name: String) -> Html5Func {
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String
        let cls = NSClassFromString(nameSpace! + "." + name) as! Html5Func.Type
        let ins = cls.init()
        
        return ins;
    }
}
