//
//  CRUDViewController.swift
//  TestLab
//
//  Created by Randolph on 6/28/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

class CRUDViewController: UITableViewController {
    
    var persons: [Person] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPersons()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        NotificationCenter.default.addObserver(self, selector: #selector(CRUDViewController.reloadTableView), name: Notification.Name("CRUDreloadTableViewNotification"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func loadPersons() {
        guard let personsData = UserDefaults.standard.object(forKey: "crud") as? [Data] else { return }
        persons = personsData.compactMap { return Person(data: $0) }
    }
    
    @objc func reloadTableView() {
        loadPersons()
        tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CRUD", for: indexPath)
        let person = persons[indexPath.row]
        cell.textLabel?.text = "\(person.firstname) \(person.lastname)"
        cell.detailTextLabel?.text = person.email
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let crudEditorViewController = segue.destination as? CrudEditorViewController
        var title = "Add Item"
        
        if segue.identifier == "cruditemadd" {
            crudEditorViewController?.itemID = ""
        } else {
            title = "Edit Item"
        }
        
        crudEditorViewController?.title = title
    }

}
