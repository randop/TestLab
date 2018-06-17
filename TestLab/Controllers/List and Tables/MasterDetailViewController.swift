//
//  MasterDetailViewController.swift
//  TestLab
//
//  Created by Randolph on 6/17/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

class MasterDetailViewController: UITableViewController {
    
    @IBOutlet weak var sliderValueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        sliderValueLabel.text = sender.value.integerText()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderValueLabel.text = slider.minimumValue.integerText()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
