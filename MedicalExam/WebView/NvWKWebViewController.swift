//
//  NvWKWebView.swift
//  kygj
//
//  Created by 黄奇 on 19/08/2017.
//  Copyright © 2017 SmartWall. All rights reserved.
//

import UIKit
import WebKit

class NvWKWebViewController: UIViewController {
    var navigationBar: UINavigationBar?
    var webView: NvWKWebView?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        navigationBar = UINavigationBar(frame: CGRect(x:0, y:20, width:self.view.bounds.size.width, height: 44))
        self.view.addSubview(navigationBar!)
        navigationBar?.pushItem(onMakeItem(), animated: true);
        
        webView = NvWKWebView(frame: CGRect(x:0, y:64, width:self.view.bounds.size.width, height:self.view.bounds.size.height-69))
        webView?.navigationDelegate = self
        //webView?.configuration.userContentController.add(self, name: "_T_")
        view.addSubview(webView!)//
        let myUrl = URL(string: "http://www.sohu.com")!
        webView?.load(URLRequest(url: myUrl));
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    func onMakeItem() ->UINavigationItem {
        let navigationItem = UINavigationItem()
        navigationItem.title = "This is From Huangqi"
        
        let leftBtn = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NvWKWebViewController.close))
        navigationItem.setLeftBarButton(leftBtn, animated: true)
        
        
        return navigationItem
    }

    func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension NvWKWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        let cred = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, cred)
    }
}

extension NvWKWebViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

    }
}
