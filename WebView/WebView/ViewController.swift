//
//  ViewController.swift
//  WebView
//
//  Created by Nick Nguyen on 2/11/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,WKNavigationDelegate,WKUIDelegate {

     var webView: WKWebView!
    
    override func loadView() {
          webView = WKWebView()
              webView.navigationDelegate = self
              webView.uiDelegate = self
              view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://music.apple.com/us/artist/selena-gomez/280215834?uo=4")!

              webView.load(URLRequest(url: url))
    }


}

