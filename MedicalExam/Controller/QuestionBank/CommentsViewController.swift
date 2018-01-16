//
//  CommentsViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 15/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit
import WebKit

class CommentsViewController: UIViewController {
    var questionGuid: String?
    var webView: NvWKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = NvWKWebView(frame: CGRect(x:0, y:60, width:self.view.bounds.size.width, height:self.view.bounds.size.height), uiViewController: self)
        view.addSubview(webView!)
        
//        let params: [String: String] = ["subjectName": subjectName!, "chapterGuid": chapterGuid!, "chapterName": chapterName!]
//        webView?.loadHtml(name: "html/question_board", params: params)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
