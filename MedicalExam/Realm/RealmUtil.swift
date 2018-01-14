//
//  RealmUtil.swift
//  MedicalExam
//
//  Created by 黄奇 on 06/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit
import RealmSwift

class RealmUtil {
    static let dbName = "itek-db"
    static let sharedInstance = try! Realm()
    
    //--MARK: initialize Realm
    static func initEncryptionRealm() {
        var key = Data(count: 64)
        _ = key.withUnsafeMutableBytes {
            mutableBytes in
            SecRandomCopyBytes(kSecRandomDefault, key.count, mutableBytes)
        }
        
        var config = Realm.Configuration(encryptionKey: key)
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(dbName).realm")
        
        let folderPath = config.fileURL!.deletingLastPathComponent().path
        try! FileManager.default.setAttributes([FileAttributeKey.protectionKey: FileProtectionType.none], ofItemAtPath: folderPath)
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    static func initRealm() {
        var config = Realm.Configuration()
        
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(dbName).realm")
        let folderPath = config.fileURL!.deletingLastPathComponent().path
        try! FileManager.default.setAttributes([FileAttributeKey.protectionKey: FileProtectionType.none], ofItemAtPath: folderPath)
        
        Realm.Configuration.defaultConfiguration = config
    }
    
    //--MARK: Operate Realm
    static func doWriteHandler(_ closure: () -> ()){
        try! sharedInstance.write {
            closure()
        }
    }
    
    static func backgroundDoWriteHandler(_ closure: () -> ()) {
        try! Realm().write {
            closure()
        }
    }
    
    static func addCanUpdate<T: Object>(_ object: T) {
        try! sharedInstance.write {
            sharedInstance.add(object, update: true)
        }
    }
    
    static func add<T: Object>(_ object: T) {
        try! sharedInstance.write {
            sharedInstance.add(object)
        }
    }
    
    static func addListDataAsync<T: Object>(_ objects: [T]) {
        let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        queue.async {
            autoreleasepool {
                let realm = try! Realm()
                
                realm.beginWrite()
                for item in objects {
                    realm.add(item, update: true)
                }
                try! realm.commitWrite()
            }
        }
    }
    
    static func addListData<T: Object>(_ objects: [T]) {
        autoreleasepool {
            let realm = try! Realm()
            
            realm.beginWrite()
            for item in objects {
                realm.add(item, update: true)
            }
            
            try! realm.commitWrite()
        }
    }
    
    static func delete<T: Object> (_ object: T) {
        try! sharedInstance.write {
            sharedInstance.delete(object)
        }
    }
    
    static func delete<T: Object> (_ objects: [T]) {
        try! sharedInstance.write {
            sharedInstance.delete(objects)
        }
    }
    
    static func delete<T: Object> (_ objects: Results<T>) {
        try! sharedInstance.write {
            sharedInstance.delete(objects)
        }
    }
    
    static func delete<T> (_ objects: LinkingObjects<T>) {
        try! sharedInstance.write {
            sharedInstance.delete(objects)
        }
    }
    
    static func deleteAll() {
        try! sharedInstance.write {
            sharedInstance.deleteAll()
        }
    }
    
    static func selectByFilterString<T: Object> (_: T.Type, filter: String) -> Results<T> {
        return sharedInstance.objects(T.self).filter(filter)
    }
    
    static func selectByPredicate<T: Object> (_: T.Type, predicate: NSPredicate) -> Results<T> {
        return sharedInstance.objects(T.self).filter(predicate)
    }
    
    static func backgroundSelectByPredicate<T: Object> (_: T.Type, predicate: NSPredicate) -> Results<T> {
        return try! Realm().objects(T.self).filter(predicate)
    }
    
    static func selectAll<T: Object> (_: T.Type) -> Results<T> {
        return sharedInstance.objects(T.self)
    }
    
    static func select<T: Object> (_: T.Type, forPrimaryKey: String) -> T {
        return sharedInstance.object(ofType: T.self, forPrimaryKey: forPrimaryKey)!
    }
}
