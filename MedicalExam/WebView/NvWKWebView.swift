//
//  NvWKWebView.swift
//  kygj
//
//  Created by 黄奇 on 19/08/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//

import UIKit
import WebKit
import SwiftyJSON

class NvWKWebView: WKWebView {
    var uiViewController: UIViewController?
    
    init(frame: CGRect, uiViewController: UIViewController){
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        config.preferences.minimumFontSize = 10
        config.preferences.javaScriptEnabled = true
        config.processPool = WKProcessPool()
        config.userContentController = WKUserContentController()
        
        super.init(frame:frame, configuration: config)
        self.uiViewController = uiViewController
        self.configuration.userContentController.add(self, name: "invoke")
        self.navigationDelegate = self
        self.uiDelegate = self
        
        self.initClients()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NvWKWebView {
    func initClients() {
        loadSdk()
        registerClientFuncs(module: "qb", funcs: ["getChapterQuestion,startDoQuestion,getDoQuestion,getCommentCount,saveDoQuestion,getDoQuestionInfo"])
        addKVO()
    }
    
    private func loadSdk() {
        let sdkJs = self.loadJsFile(name: "html/api/html5_sdk_m")
        
        self.evaluateJavaScript(sdkJs) {
            (_, err) in
            if err != nil {
                print("\(String(describing: err))")
            }
        }
    }
    
    private func registerClientFuncs(module: String, funcs:[String]) {
        let script = "iTek.__html5_reg(\"\(module)\", \"\(funcs.joined(separator: ","))\")"
        
        self.evaluateJavaScript(script) {
            (_, err) in
            if err != nil {
                print("\(String(describing: err))")
            }
        }
        
        print("register:" + funcs.joined(separator: ","))
    }
    
    private func addKVO() {
        self.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        self.addObserver(self, forKeyPath: "title", options: .new, context: nil)
        self.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    private func pubReadyEvent() {
        pubEvent("Ready")
    }
    
    private func loadJsFile(name: String) -> String {
        let path = Bundle.main.path(forResource: name, ofType: "js")
        
        return try! String(contentsOfFile: path!, encoding: String.Encoding.utf8)
    }
    
    func pubEvent(_ eventName: String) -> Void {
        let script = "iTek.__html5_evt(\"\(eventName)\")"
        
        self.evaluateJavaScript(script) {
            (_, err) in
            if err != nil {
                print("\(String(describing: err))")
            }
        }
    }
    
    func setLocalVar(name: String, value: String) {
        let script = "iTek.__html5_setLocalInfo(\"\(name)\",\"\(value)\")"
        
        self.evaluateJavaScript(script) {
            (_, err) in
            if err != nil {
                print("\(String(describing: err))")
            }
        }
    }
    
    func loadHtml(name: String, params: [String: String]?) -> Void{
        if let params = params {
            for (k, v) in params {
               self.setLocalVar(name: k, value: v)
            }
        }
        let path = Bundle.main.path(forResource: name, ofType: "html")
        let pageURL = URL(fileURLWithPath: path!)
        
        self.load(URLRequest(url: pageURL))
    }
    
    func sendCallback(callbackId: String, result: JSON?) {
        var json = JSON()
        json["callbackId"].string = callbackId
        json["body"] = result!
        
        let script = "iTek.__html5_cb(\(json))"
        
        self.evaluateJavaScript(script) {
            (_, err) in
            if err != nil {
                print("\(String(describing: err))")
            }
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
        }
        
        if !self.isLoading {
            self.pubReadyEvent()
        }
    }
}

extension NvWKWebView: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        if message.name == "invoke" {
            let json = JSON(message.body)[0]
            let module = json["module"].string!
            let funcName = json["funcName"].string!
            let data = JSON.init(parseJSON: json["data"].string!)
            
            WebViewModuleFuncs.exec(nvWebView: self, module: module, funcName: funcName, data: data)
        }
    }
}

extension NvWKWebView: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let cred = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, cred)
    }
}

extension NvWKWebView: WKUIDelegate {
    private func present(_ viewControllertoPresent: UIViewController) {
        self.uiViewController?.present(viewControllertoPresent, animated: true, completion: nil)
    }
    // 监听通过JS调用警告框
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler()
        }))
        self.present(alert)
    }
    
    // 监听通过JS调用提示框
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            completionHandler(false)
        }))
        self.present(alert)
    }
    
    // 监听JS调用输入框
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        // 类似上面两个方法
    }
}
