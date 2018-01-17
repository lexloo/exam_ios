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
    @IBOutlet weak var vTool: UIView!
    @IBOutlet weak var vCommentInput: UIView!
    @IBOutlet weak var constraintBottom: NSLayoutConstraint!
    @IBOutlet weak var txtComments: UITextView!
    
    @IBAction func newCommentClick(_ sender: UIButton) {
        vCommentInput.isHidden = false
    }
    @IBAction func newNoteClick(_ sender: UIButton) {

    }
    @IBAction func newLikesClick(_ sender: UIButton) {
    }
    @IBAction func CommentsOnMeClick(_ sender: UIButton) {
    }
    
    @IBAction func commentOkClick(_ sender: UIButton) {
        vCommentInput.isHidden = true
        txtComments.resignFirstResponder()
    }
    @IBAction func CommentCancelClick(_ sender: UIButton) {
        vCommentInput.isHidden = true
        txtComments.resignFirstResponder()
    }
    @IBAction func returnClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(DoQuestionViewController.keyboardWillChange(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
        
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
            
            let params = ["subjectName": subjectName!, "chapterGuid": chapterGuid!, "chapterName": chapterName!, "index": String(i), "questionGuid": qs[i].guid!]
            tmpView.loadHtml(name: "html/do_question", params: params)
            
            svContainer.addSubview(tmpView)
        }
    }
    
    func keyboardWillChange(_ notification: Notification) {
        if let userInfo = notification.userInfo,
        let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            
            self.constraintBottom.constant = -intersection.height
            UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions(rawValue: curve), animations: {self.view.layoutIfNeeded()}, completion: nil)
        }
    }
}
