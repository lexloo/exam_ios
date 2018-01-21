//
//  SelectQuestionViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 07/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit
import WebKit

class SelectQuestionViewController: BaseUIViewController {
    @IBOutlet weak var lblSubject: UILabel!
    var subjectName: String?
    var chapterName: String?
    var chapterGuid: String?
    var type: String?
    
    var webView: NvWKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = NvWKWebView(frame: CGRect(x:0, y:60, width:self.view.bounds.size.width, height:self.view.bounds.size.height), uiViewController: self)
        view.addSubview(webView!)
        
        let params: [String: String] = ["subjectName": subjectName!, "chapterGuid": chapterGuid!, "chapterName": chapterName!, "type": type!]
        webView?.loadHtml(name: "html/question_board", params: params)
        
        lblSubject.text = subjectName!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func redoClick(_ sender: UIButton) {
    }
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
