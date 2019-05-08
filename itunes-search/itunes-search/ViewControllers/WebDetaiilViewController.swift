//
//  WebDetaiilViewController.swift
//  itunes-search
//
//  Created by Hector Steven on 5/7/19.
//  Copyright © 2019 Hector Steven. All rights reserved.
//

import UIKit
import WebKit

class WebDetaiilViewController: UIViewController, WKNavigationDelegate {

	
	override func loadView() {
		super.loadView()
		webView = WKWebView()
		webView.navigationDelegate = self
		view = webView
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		guard let result = result else { return }
		if let url = result.url {
			let url = URL(string: url)!
			webView.load(URLRequest(url: url))
			webView.allowsBackForwardNavigationGestures = true
		}
        
    }
    
	var result: SearchResult? {
		didSet{
			print("set")
		}
	}
	var webView: WKWebView!
}
