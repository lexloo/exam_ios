//
//  UIView.swift
//  MedicalExam
//
//  Created by 黄奇 on 28/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import UIKit

extension UIView {
    func firstViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: { $0?.superview }) {
            if let responder = view?.next {
                if responder.isKind(of: UIViewController.self) {
                    return responder as? UIViewController
                }
            }
        }
        
        return nil
    }
}
