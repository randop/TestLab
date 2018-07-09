//
//  NewsViewController.swift
//  TestLab
//
//  Created by Randolph on 7/5/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Loading..."
        
        if let aUrl = url {
            webView.loadRequest(URLRequest(url: aUrl))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        if let aUrl = url {
            self.title = aUrl.host
        }
    }
}
