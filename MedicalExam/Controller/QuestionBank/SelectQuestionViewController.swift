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
    var subjectName: String?
    var chapterName: String?
    var chapterGuid: String?
    var type: String?
    
    weak var webView: NvWKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = NvWKWebView(frame: self.view.bounds, uiViewController: self)
        view.addSubview(webView!)

        let params: [String: String] = ["subjectName": subjectName!, "chapterGuid": chapterGuid!, "chapterName": chapterName!, "type": type!]
        webView?.loadHtml(name: "html/question_board", params: params)
        
        self.title = subjectName!
        self.subscribeNotification(name: "refresh_select_question", selector: #selector(refreshQuestion(notification:)))
        
        let closeItem = UIBarButtonItem(title: "题库", style: .done, target: self, action: #selector(close))
        self.navigationItem.leftBarButtonItem = closeItem
        
        let redoItem = UIBarButtonItem(title: "重做", style: .plain, target: self, action: #selector(redo))
        self.navigationItem.rightBarButtonItem = redoItem
    }

    @objc func refreshQuestion(notification: Notification) {
        self.webView?.evaluateJavaScript("vue.reloadQuestions()")
    }
    
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func redo() {
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
