//
//  TodoViewController.swift
//  TestLab
//
//  Created by Randolph on 2/4/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let DB = DAO.instance
    var todos = [Todo]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let strokeEffect: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue,
            NSAttributedStringKey.strikethroughColor: UIColor.red,
            NSAttributedStringKey.foregroundColor: UIColor.gray
        ]
        cell.textLabel?.attributedText = NSAttributedString(string: "test", attributes: strokeEffect)
    
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
