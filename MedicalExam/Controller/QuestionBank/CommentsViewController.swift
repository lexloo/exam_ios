//
//  CommentsViewController.swift
//  MedicalExam
//
//  Created by 黄奇 on 15/01/2018.
//  Copyright © 2018 SmartWall. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON

class CommentsViewController: UIViewController {
    var questionGuid: String?
    var commentGuid: String?
    var commentName: String?
    var commentComment: String?
    var isReply: Bool? = false
    
    var webView: NvWKWebView?
    
    @IBOutlet weak var vWebViewContainer: UIView!
    @IBOutlet weak var vCommentInput: UIView!
    @IBOutlet weak var tvInput: UITextView!
    @IBOutlet weak var lcBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = NvWKWebView(frame: CGRect(x:0, y:0, width:self.vWebViewContainer.bounds.width, height:self.vWebViewContainer.bounds.height), uiViewController: self)
        webView?.callback = self
        vWebViewContainer.addSubview(webView!)
        
        let params: [String: String] = ["questionGuid": questionGuid!]
        webView?.loadHtml(name: "html/comments", params: params)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CommentsViewController.keyboardWillChange(_:)), name: .UIKeyboardWillChangeFrame, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func returnClick(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelCommentClick(_ sender: UIButton) {
        vCommentInput.isHidden = true
        tvInput.resignFirstResponder()
        
        self.isReply = false
    }
    @IBAction func okCommentClick(_ sender: UIButton) {
        let userInfo = Global.userInfo
        let userGuid = userInfo.guid
        let userName = userInfo.name
        let comment = self.tvInput.text
        
        if self.isReply! {
            let parameters = ["questionGuid": self.questionGuid!, "userGuid": self.commentGuid!, "userName": self.commentName!, "comment": self.commentComment!, "replierGuid": userGuid!, "replierName": userName!, "replierComment": comment!]
            HttpUtil.postReturnString("question/reply_comment", parameters: parameters) {
                result in
                
                self.vCommentInput.isHidden = true
                self.tvInput.resignFirstResponder()
                self.tvInput.text = ""
                
                self.isReply = false
                self.webView?.evaluateJavaScript("vue.insertComment(\(JSON(parameters)))")
            }
        } else {
            let parameters = ["questionGuid": self.questionGuid!, "userGuid": userGuid!, "userName": userName!, "comment": comment!]
            HttpUtil.postReturnString("question/comment", parameters: parameters) {
                result in
         
                self.vCommentInput.isHidden = true
                self.tvInput.resignFirstResponder()
                self.tvInput.text = ""
                
                self.isReply = false
                self.webView?.evaluateJavaScript("vue.insertComment(\(JSON(parameters)))")
            }
        }
    }
    
    @IBAction func commentsOnMeClick(_ sender: UIButton) {
        
    }
    
    @IBAction func writeCommentClick(_ sender: UIButton) {
        vCommentInput.isHidden = false
        tvInput.becomeFirstResponder()
    }
    
    @objc func keyboardWillChange(_ notification: Notification) {
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            
            self.lcBottom.constant = -intersection.height
            UIView.animate(withDuration: duration, delay: 0.0, options: UIViewAnimationOptions(rawValue: curve), animations: {self.view.layoutIfNeeded()}, completion: nil)
        }
    }
}

extension CommentsViewController: WKWebViewCallback {
    func exec(funcName: String, data: JSON) {
        print(funcName)
        if funcName == "addComment" {
            print(data)
            self.commentGuid = data["params"]["userGuid"].string
            self.commentName = data["params"]["userName"].string
            self.commentComment = data["params"]["comment"].string
            self.isReply = true
            
            vCommentInput.isHidden = false
            tvInput.becomeFirstResponder()
        }
    }
}
