//
//  FileUtils.swift
//  MedicalExam
//
//  Created by 黄奇 on 03/02/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import Foundation

class FileUtils {
    static func ensureDirectory(_ folder: URL) {
        let manager  = FileManager.default
        let exists = manager.fileExists(atPath: folder.path)
        
        if !exists {
            try! manager.createDirectory(at: folder, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    static func saveAvatar(_ image: Data, _ name: String) {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let m = path.appendingPathComponent("avatar", isDirectory: true)
        let f = m.appendingPathComponent(name)

        do {
            try image.write(to: f)
        } catch  {
            ensureDirectory(m)
            try! image.write(to: f)
        }
    }
    
    static func getAvatarFileName(_ name: String) -> String {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let m = path.appendingPathComponent("avatar", isDirectory: true)
        let f = m.appendingPathComponent(name)
        
        return f.path
    }
}
