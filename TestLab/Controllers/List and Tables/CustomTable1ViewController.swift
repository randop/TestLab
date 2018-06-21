//
//  CustomTable1ViewController.swift
//  TestLab
//
//  Created by Randolph on 6/21/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

class CustomTable1ViewController: UITableViewController {

    let titles: [String] = ["Peter", "James", "John", "Matthew", "Mary", "Elizabeth", "Sarah"]
    let subtitles: [String] = ["General Manager", "Administrative Officer", "Teacher", "Accountant", "Doctor", "Nurse", "Secretary"]
    let colors: [UIColor] = [.red, .green, .blue, .yellow, .magenta, .cyan, .orange]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Custom1", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = subtitles[indexPath.row]
        cell.imageView?.image = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
        cell.imageView?.tintColor = colors[indexPath.row]
        return cell
    }
}
