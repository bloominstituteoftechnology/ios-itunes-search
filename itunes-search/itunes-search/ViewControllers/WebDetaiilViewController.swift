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
		
		let webconfig = WKWebViewConfiguration()
		webView = WKWebView(frame: .zero, configuration: webconfig)
		webView.navigationDelegate = self
		view = webView
		
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		guard let result = result else { return }
		
		if let myurl = result.url {
			
			let url = URL(string: "https://www.google.com/")!
			let myRequest = URLRequest(url: url)
			webView.load(myRequest)
			webView.allowsBackForwardNavigationGestures = true
			
			//https://itunes.apple.com/us/app/twitter/id333903271?mt=8&ign-mpt=uo%3D4
			print(myRequest)
		} else  {
			print("Error : No url ")
		}
		
    }
	
	var result: SearchResult?
	var webView: WKWebView!
}
