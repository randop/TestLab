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
    @IBOutlet var webViewNavButtons: [UIBarButtonItem]!
    
    @IBAction func openInSafariAction(_ sender: UIBarButtonItem) {
        if let aUrl = webView.request?.url {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(aUrl, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(aUrl)
            }
        }
    }
    
    @IBAction func goBackAction(_ sender: UIBarButtonItem) {
        webView.stopLoading()
        webView.goBack()
    }
    
    @IBAction func goForwardAction(_ sender: UIBarButtonItem) {
        webView.stopLoading()
        webView.goForward()
    }
    
    @IBAction func refreshOrStopAction(_ sender: UIBarButtonItem) {
        webView.stopLoading()
        webView.reload()
    }
    
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWebViewButtonState()
        
        if let aUrl = url {
            self.title = "Loading..."
            webView.loadRequest(URLRequest(url: aUrl))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        updateWebViewButtonState()
        
        if let aUrl = url {
            self.title = aUrl.host
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        updateWebViewButtonState(true)
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        updateWebViewButtonState(true)
    }
    
    func updateWebViewButtonState(_ didFinishLoad: Bool = false) {
        for button in webViewNavButtons {
            button.isEnabled = false
            
            if button.title.trimmedText == "back" && webView.canGoBack {
                button.isEnabled = true
            } else if button.title.trimmedText == "forward" && webView.canGoForward {
                button.isEnabled = true
            } else if button.title.trimmedText == "reload" {
                button.isEnabled = true
                if didFinishLoad {
                    button.image = UIImage(named: "reload")
                } else {
                    button.image = UIImage(named: "cross")
                }
            }
        }
    }
}
