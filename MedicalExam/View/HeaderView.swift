//
//  HeaderView.swift
//  MedicalExam
//
//  Created by 黄奇 on 24/12/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//
import UIKit

typealias HeaderViewClickBack = (Bool) -> Void

class HeaderView: UITableViewHeaderFooterView {
    private lazy var directionImageView: UIImageView? = UIImageView()
    var expandCallBack: HeaderViewClickBack?
    var model: SectionModel? = nil
    
    var sectionModel: SectionModel? {
        didSet {
            textLabel?.text = sectionModel?.title
            if self.sectionModel!.isExpanded! {
                self.directionImageView?.transform = CGAffineTransform(rotationAngle: .pi)
            } else {
                self.directionImageView?.transform = CGAffineTransform.identity
            }
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        self.layer.borderWidth = 1
        self.layer.borderColor = BaseColor.tableSeperatorColor.cgColor
        let w = UIScreen.main.bounds.size.width
        let h = 48
        
        directionImageView = UIImageView.init(image: UIImage.init(named: "arrow_down"))
        directionImageView?.frame = CGRect(x: Int(w - 30), y: (h - 8) / 2, width: 15, height: 8)
        contentView.addSubview(directionImageView!)
        
        let button = UIButton.init(frame: CGRect(x: 0, y: 0, width: Int(w), height: h))
        contentView.addSubview(button)
        
        self.contentView.backgroundColor = BaseColor.tableSectionColor
        
        button.addTarget(self, action: #selector(clickHeader(sender:)), for: UIControlEvents.touchUpInside)
    }
    
    @objc func clickHeader(sender: UIButton) {
        sectionModel?.isExpanded = !((sectionModel?.isExpanded)!)
        UIView.animate(withDuration: 0.25) {
            if (self.sectionModel?.isExpanded)! {
                self.directionImageView?.transform = CGAffineTransform(rotationAngle: .pi)
            } else {
                self.directionImageView?.transform = CGAffineTransform.identity
            }
        }
        if (self.expandCallBack != nil) {
            if !(self.sectionModel?.isLoaded)!{
                self.sectionModel?.loadCellModels()
            }
            
            expandCallBack!((self.sectionModel?.isExpanded)!)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
