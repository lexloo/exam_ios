//
//  NvWKWebView.swift
//  kygj
//
//  Created by 黄奇 on 19/08/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//

import UIKit
import WebKit

class NvWKWebView: WKWebView {
    private var uiViewController: UIViewController?
    
    init(frame: CGRect, uiViewController: UIViewController){
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        config.preferences.minimumFontSize = 10
        config.preferences.javaScriptEnabled = true
        config.processPool = WKProcessPool()
        config.userContentController = WKUserContentController()
        
        super.init(frame:frame, configuration: config)
        self.uiViewController = uiViewController
        self.configuration.userContentController.add(self, name: "__Native__")
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
        pubReadyEvent()
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
    
    func loadHtml(name: String) -> Void{
        let path = Bundle.main.path(forResource: name, ofType: "html")
        let pageURL = URL(fileURLWithPath: path!)
        
        self.load(URLRequest(url: pageURL))
    }
}

extension NvWKWebView: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//        if message.name == "invoke" {
//            if message.body is Dictionary<String, String> {
//                let m = message.body as! Dictionary<String, String>
//                let data = m["data"]?.data(using: String.Encoding.utf8)
//                let json = try? JSONSerialization.jsonObject(with: data!, options:[]) as! [String: Any]
//                if (m["module"] == "ui") {
//                    if (m["funcName"] == "goURL") {
//                        let url = json?["options"] as! String
//
//                        let h = NvWebViewController(url: url)
//                        self.present(h, animated: true, completion: nil)
//                    } else if (m["funcName"] == "close") {
//                        close()
//                    }
//                }
//            }
//        }
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
