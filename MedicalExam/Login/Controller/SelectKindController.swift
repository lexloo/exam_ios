//
//  SelectCategoryController.swift
//  MedicalExam
//
//  Created by 黄奇 on 06/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit
import Foundation

class SelectKindController: SingleSelectorViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "选择考试类别"
        self.dataSource = self
        self.topView?.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func selectItem(_ item: SelectItem) {
        let selectCategoryVC = SelectCategoryController()
        selectCategoryVC.kindGuid = item.guid!
        self.present(selectCategoryVC, animated: true, completion: nil)
    }
}

extension SelectKindController: TopNaviViewDelegate {
    func leftClick() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SelectKindController: SelectDataSource {
    func queryItemData(_ cb: @escaping ([SelectItem]?) -> Void) {
        let items = [SelectItem(guid: "61AEAB78A7CD3671E050840A063959A8", name: "医师资格"), SelectItem(guid: "61AEAB78A7CE3671E050840A063959A8", name: "卫生资格")]
        
        cb(items)
    }
}
