//
//  MiscViewController.swift
//  TestLab
//
//  Created by Randolph on 2/9/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

class MiscViewController: UIViewController {
    let pending = UIAlertController(title: "Please wait...", message: nil, preferredStyle: .alert)
    
    var timer = Timer()
    
    @IBAction func showIndicator(_ sender: Any) {
        self.present(pending, animated: true, completion: nil)
        
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(dismissPending), userInfo: nil, repeats: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            dismissPending()
        }
    }
    
    @objc func dismissPending() {
        print("dismiss")
        self.pending.dismiss(animated: true, completion: nil)
    }
    
}
