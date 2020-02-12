//
//  DetailViewController.swift
//  ITunesSearch
//
//  Created by Nick Nguyen on 2/11/20.
//  Copyright © 2020 Nick Nguyen. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var webView: WKWebView!
    var urlString = ""
   
    override func loadView() {
        
        webView = WKWebView()
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view = webView
        
    }
  
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(urlString)
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        self.view.addSubview(webView)
       let url = URL(string: "https://music.apple.com/us/artist/justin-bieber/320569549?uo=4")!

        webView.load(URLRequest(url: url))
      
        
    }
 
   
}
