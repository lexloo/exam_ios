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
    init(frame: CGRect){
        let config = WKWebViewConfiguration()
        config.preferences = WKPreferences()
        config.preferences.minimumFontSize = 10
        config.preferences.javaScriptEnabled = true
        config.processPool = WKProcessPool()
        config.userContentController = WKUserContentController()
        
        super.init(frame:frame, configuration: config)
        
//        self.configuration.userContentController.add(self, name: "__Native__")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

