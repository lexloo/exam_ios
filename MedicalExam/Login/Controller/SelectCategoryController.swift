//
//  SelectCategoryController.swift
//  MedicalExam
//
//  Created by 黄奇 on 06/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit
import Foundation

class SelectCategoryController: UIViewController {
    @IBOutlet weak var naviTopView: NaviTopView!
    @IBOutlet weak var btnSelectCategory: UIButton!
   
    var pvExamCategory: UIPickerView?
    
    @IBOutlet weak var bpvCatagory: BottomPopupView!
    let kind1 = Kind(guid: "61AEAB78A7CD3671E050840A063959A8", name:"医师资格");
    let kind2 = Kind(guid:"61AEAB78A7CE3671E050840A063959A8", name:"卫生资格");
    
    var catagorys: [Kind: [Catagory]]?
    var kindArr: [Kind]?
    var selectKind: Kind?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviTopView.btnReturn.addTarget(self, action: #selector(SelectCategoryController.close), for: UIControlEvents.touchUpInside)
        
        pvExamCategory = UIPickerView()
        pvExamCategory?.selectedRow(inComponent: 0)
        pvExamCategory?.selectedRow(inComponent: 1)
        pvExamCategory?.dataSource = self
        pvExamCategory?.delegate = self
        
        bpvCatagory.vmContainer.addSubview(pvExamCategory!)
        bpvCatagory.btnOK.addTarget(self, action: #selector(SelectCategoryController.setCategory), for: .touchUpInside)
        
        
        loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func setCategory() {
        let kind: Kind = self.kindArr![(self.pvExamCategory?.selectedRow(inComponent: 0))!]
        let catagory: Catagory = self.catagorys![kind]![(self.pvExamCategory?.selectedRow(inComponent: 1))!]
        let title = kind.name + "|" + catagory.name!
        self.btnSelectCategory.setTitle(title, for: .normal)
        
        //save
        let userInfo = UserInfo()
        userInfo.copyFrom(Global.userInfo)
        userInfo.examKind = kind.guid
        userInfo.examCategory = catagory.guid
        
        RealmUtil.addCanUpdate(userInfo)
        Global.userInfo.copyFrom(userInfo)
        
        let parameters:Dictionary = ["guid": userInfo.guid!, "kind": userInfo.examKind!, "category": userInfo.examCategory!]
        HttpUtil.postReturnString("user/kind_category", parameters: parameters) {
            json in
        }
    }
    
    @IBAction func selectCategory(_ sender: UIButton) {
        bpvCatagory.isHidden = false
    }
    
    func loadData() {
        kindArr = [kind1, kind2]
        selectKind = kind1
        var catagory1: [Catagory] = []
        var catagory2: [Catagory] = []
        
        HttpUtil.postReturnData("list/all_catagory", parameters: nil) {
            json in
            for (_, item) in json {
                let catagory = Catagory()
                catagory.mapping(item)
                
                if "61AEAB78A7CD3671E050840A063959A8" == catagory.kindGuid! {
                    catagory1.append(catagory)
                } else {
                    catagory2.append(catagory)
                }
            }
            self.catagorys = [self.kind1: catagory1, self.kind2: catagory2]
            self.pvExamCategory?.reloadAllComponents()
        }
    }
}

extension SelectCategoryController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if 0 == component {
            return (kindArr?.count)!
        }
        
        if let cs = catagorys {
            return cs[selectKind!]!.count
        } else {
            return 0
        }
    }
}

extension SelectCategoryController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return kindArr?[row].name
        } else {
            if let cs = catagorys {
                return cs[selectKind!]![row].name
            } else {
                return ""
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectKind = kindArr?[row]
            pickerView.reloadComponent(1)
        }
    }
}

