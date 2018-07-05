//
//  NewsViewController.swift
//  TestLab
//
//  Created by Randolph on 7/5/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let aUrl = url {
            webView.loadRequest(URLRequest(url: aUrl))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
