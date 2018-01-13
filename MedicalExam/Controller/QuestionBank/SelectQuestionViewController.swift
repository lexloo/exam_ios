//
//  SelectQuestionViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 07/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit
import WebKit

class SelectQuestionViewController: UIViewController {
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblChapter: UILabel!
    var subjectName: String?
    var chapterName: String?
    var chapterGuid: String?
    
    var webView: NvWKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = NvWKWebView(frame: CGRect(x:0, y:100, width:self.view.bounds.size.width, height:self.view.bounds.size.height), uiViewController: self)
        view.addSubview(webView!)
        
        webView?.loadHtml(name: "html/question_board")
        
        lblSubject.text = subjectName!
        lblChapter.text = chapterName!
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
