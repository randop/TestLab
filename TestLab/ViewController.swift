//
//  ViewController.swift
//  TestLab
//
//  Created by Randolph on 2/4/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let contents = ["Todo List", "List and Tables", "Camera and Images", "Audio and Video", "Location"]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = contents[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch contents[indexPath.row] {
        case "Todo List":
            performSegue(withIdentifier: "showTodo", sender: self)
        case "List and Tables":
            performSegue(withIdentifier: "showTable", sender: self)
        default:
            break
        }
    }
}
