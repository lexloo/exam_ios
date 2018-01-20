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
    
    @IBOutlet weak var vWebViewContainer: UIView!
    @IBOutlet weak var vCommentInput: UIView!
    @IBOutlet weak var tvInput: UITextView!
    @IBOutlet weak var lcBottom: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = NvWKWebView(frame: CGRect(x:0, y:0, width:self.vWebViewContainer.bounds.width, height:self.vWebViewContainer.bounds.height), uiViewController: self)
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
    }
    @IBAction func okCommentClick(_ sender: UIButton) {
        vCommentInput.isHidden = true
        tvInput.resignFirstResponder()
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
