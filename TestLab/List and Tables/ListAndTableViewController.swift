//
//  ListAndTableViewController.swift
//  TestLab
//
//  Created by Randolph on 2/9/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

class ListAndTableViewController: UITableViewController {

    let menus = ["CRUD"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = menus[indexPath.row]
        return cell
    }
}
