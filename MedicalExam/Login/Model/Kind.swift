//
//  ExamKind.swift
//  MedicalExam
//
//  Created by 黄奇 on 06/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
//import UIKit
//import Foundation

class Kind {
    var guid: String
    var name: String
    
    init(guid: String, name: String) {
        self.guid = guid
        self.name = name
    }
}

extension Kind: Hashable {
    public var hashValue: Int {
        return self.guid.hashValue
    }
    
    static func == (lhs: Kind, rhs: Kind) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
