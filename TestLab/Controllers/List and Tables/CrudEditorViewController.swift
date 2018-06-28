//
//  CrudEditorViewController.swift
//  TestLab
//
//  Created by Randolph on 6/28/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

class CrudEditorViewController: UITableViewController {
    var itemID = ""
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func doneButtonAction(_ sender: Any) {
        var persons: [Person] = []
        var willAdd = true
        if let personsData = UserDefaults.standard.object(forKey: "crud") as? [Data] {
            persons = personsData.compactMap { return Person(data: $0) }
            for person in persons {
                if person.id == itemID {
                    willAdd = false
                }
            }
        }
        
        if willAdd {
            var newPerson = Person(id: UUID().uuidString, firstname: "", lastname: "", email: "")
            if !firstnameTextField.text.isBlank {
                newPerson.firstname = firstnameTextField.text!
            }
            if !lastnameTextField.text.isBlank {
                newPerson.lastname = lastnameTextField.text!
            }
            if !emailTextField.text.isBlank {
                newPerson.email = emailTextField.text!
            }
            persons.append(newPerson)
        }
        
        let personsData = persons.map { $0.encode() }
        UserDefaults.standard.set(personsData, forKey: "crud")
 
        navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: Notification.Name("CRUDreloadTableViewNotification"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
