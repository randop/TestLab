//
//  CrudEditorViewController.swift
//  TestLab
//
//  Created by Randolph on 6/28/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import UIKit

class CrudEditorViewController: UITableViewController {
    var thePerson = Person(id: "", firstname: "", lastname: "", email: "")
    
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func doneButtonAction(_ sender: Any) {
        var persons: [Person] = []
        
        thePerson.firstname = firstnameTextField.trimmedText
        thePerson.lastname = lastnameTextField.trimmedText
        thePerson.email = emailTextField.trimmedText
        
        if !thePerson.email.isEmail {
            let alert = UIAlertController(title: "Invalid Email", message: "Please enter a valid email address", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if let personsData = UserDefaults.standard.object(forKey: "crud") as? [Data] {
            persons = personsData.compactMap {
                if let person = Person(data: $0) {
                    if person.id == thePerson.id {
                        return thePerson
                    }
                }
                
                return Person(data: $0)
            }
        }
        
        if thePerson.id == "" {
            thePerson.id = UUID().uuidString
            persons.append(thePerson)
        }
        
        let personsData = persons.map { $0.encode() }
        UserDefaults.standard.set(personsData, forKey: "crud")
 
        navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: Notification.Name("CRUDreloadTableViewNotification"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        firstnameTextField.text = thePerson.firstname
        lastnameTextField.text = thePerson.lastname
        emailTextField.text = thePerson.email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
