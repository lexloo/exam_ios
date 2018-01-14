//
//  DoQuestionViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 14/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit

class DoQuestionViewController: UIViewController {
    public var subjectName: String?
    public var chapterGuid: String?
    public var chapterName: String?
    public var type: String?
    public var index: String?
    public var questionGuid: String?
    
    @IBOutlet weak var lblSubjectName: UILabel!
    @IBOutlet weak var lblChapterName: UILabel!
    @IBOutlet weak var svContainer: UIScrollView!
    @IBAction func returnClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblSubjectName.text = subjectName!
        lblChapterName.text = chapterName!
        
        svContainer.scrollsToTop = false
        
        setupViewPager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    private func setupViewPager() {
        let width = self.view.bounds.width
        let height = self.view.bounds.height
        
        let qs = RealmUtil.selectByFilterString(ChapterQuestions.self, filter: "chapterGuid =='\(self.chapterGuid!)'")
        
        svContainer.contentSize = CGSize(width: width * CGFloat(qs.count), height: 0)
        
        for i in 0 ..< qs.count {
            let tmpView = NvWKWebView(frame: CGRect(x: CGFloat(i) * width, y: 0, width: width, height: height), uiViewController: self)
            
            tmpView.params = ["subjectName": subjectName!, "chapterGuid": chapterGuid!, "chapterName": chapterName!, "index": String(i), "questionGuid": qs[i].guid!]
            tmpView.html = "html/do_question";
            tmpView.reloadHtml()
            
            svContainer.addSubview(tmpView)
        }
    }
}
