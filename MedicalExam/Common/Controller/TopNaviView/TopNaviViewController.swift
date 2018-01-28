//
//  TopNaviViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 28/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit
import SnapKit

class TopNaviView: UIView {
    var btnLeft: UIButton?
    var lblTitle: UILabel?
    var title: String? {
        didSet {
            self.lblTitle?.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = BaseColor.statusBarColor
        initViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        btnLeft = UIButton(type: .custom)
        btnLeft?.setTitle("返回", for: .normal)
        btnLeft?.setTitleColor(BaseColor.naviButtonColor, for: .normal)
        self.addSubview(btnLeft!)
        
        btnLeft?.snp.makeConstraints {
            make in
            make.centerY.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(16)
        }
        
        lblTitle = UILabel()
        lblTitle?.textColor = BaseColor.naviTitleTextColor
        self.addSubview(lblTitle!)
        lblTitle?.snp.makeConstraints {
            make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
        }
    }
}
