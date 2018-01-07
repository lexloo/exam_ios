//
//  NvWKWebView.swift
//  kygj
//
//  Created by 黄奇 on 19/08/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//

import UIKit
import WebKit

class NvWebViewController: UIViewController {
    var webView: WKWebView?
    var pageUrl:String?
    
    init(url: String){
        pageUrl = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        config.preferences.minimumFontSize = 10
        config.preferences.javaScriptEnabled = true
        config.processPool = WKProcessPool()
        config.userContentController = WKUserContentController()
        
        webView = WKWebView(frame: CGRect(x:0, y:20, width:self.view.bounds.size.width, height:self.view.bounds.size.height - 20), configuration: config)
        webView?.navigationDelegate = self
        webView?.uiDelegate = self
        webView?.configuration.userContentController.add(self, name: "invoke")
        view.addSubview(webView!)
        
        let f = URL(string: self.pageUrl!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)

        webView?.load(URLRequest(url: f!))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
}

extension NvWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let cred = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, cred)
    }
}

extension NvWebViewController: WKUIDelegate {
    // 监听通过JS调用警告框
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            completionHandler()
        }))
        self.present(alert, animated: true, completion: nil)
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
        self.present(alert, animated: true, completion: nil)
    }
    
    // 监听JS调用输入框
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        // 类似上面两个方法
    }
}

extension NvWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        if message.name == "invoke" {
            if message.body is Dictionary<String, String> {
                let m = message.body as! Dictionary<String, String>
                let data = m["data"]?.data(using: String.Encoding.utf8)
                let json = try? JSONSerialization.jsonObject(with: data!, options:[]) as! [String: Any]
                if (m["module"] == "ui") {
                    if (m["funcName"] == "goURL") {
                        let url = json?["options"] as! String

                        let h = NvWebViewController(url: url)
                        self.present(h, animated: true, completion: nil)
                    } else if (m["funcName"] == "close") {
                        close()
                    }
                }
            }
        }
    }
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }
}


