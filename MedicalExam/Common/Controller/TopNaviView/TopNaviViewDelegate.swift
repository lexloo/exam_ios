//
//  TopNaviViewDelegate.swift
//  MedicalExam
//
//  Created by 黄奇 on 28/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//
import UIKit

@objc protocol TopNaviViewDelegate {
    func leftClick()
    @objc optional func rightClick()
}
