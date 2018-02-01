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
    var btnRight: UIButton?
    // 设置标题后就创建按钮
    var rightButtonTitle: String? {
        didSet {
            showRightButton = true
            btnRight = UIButton(type: .custom)
            btnRight?.setTitle(rightButtonTitle, for: .normal)
            btnRight?.setTitleColor(BaseColor.naviButtonColor, for: .normal)
            self.addSubview(btnRight!)
            
            btnRight?.snp.makeConstraints {
                make in
                make.centerY.equalToSuperview().offset(10)
                make.right.equalToSuperview().offset(-16)
            }
        }
    }
    private var showRightButton = false
    var lblTitle: UILabel?
    var title: String? {
        didSet {
            lblTitle?.text = title
        }
    }
    
    var delegate: TopNaviViewDelegate? {
        didSet {
            btnLeft?.addTarget(viewController, action: #selector(leftClick), for: .touchUpInside)
            
            if showRightButton {
                btnRight?.addTarget(viewController, action: #selector(rightClick), for: .touchUpInside)
            }
        }
    }

    // 组件所在的ViewController
    lazy var viewController: UIViewController? = {
        return firstViewController()
    }()
    
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
        btnLeft?.setImage(UIImage(named: "navi_back"), for: .normal)
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
    
    @objc private func leftClick() {
        self.delegate?.leftClick()
    }
    
    @objc private func rightClick() {
        self.delegate?.rightClick!()
    }
}
