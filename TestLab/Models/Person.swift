//
//  Person.swift
//  TestLab
//
//  Created by Randolph on 6/28/18.
//  Copyright © 2018 Randolph. All rights reserved.
//

import Foundation

struct Person {
    var id: String
    var firstname: String
    var lastname: String
    var email: String
}

extension Person {
    func encode() -> Data {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(id, forKey: "id")
        archiver.encode(firstname, forKey: "firstname")
        archiver.encode(lastname, forKey: "lastname")
        archiver.encode(email, forKey: "email")
        archiver.finishEncoding()
        return data as Data
    }
    
    init?(data: Data) {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        defer {
            unarchiver.finishDecoding()
        }
        guard let id = unarchiver.decodeObject(forKey: "id") as? String else { return nil }
        self.id = id
        
        guard let firstname = unarchiver.decodeObject(forKey: "firstname") as? String else { return nil }
        self.firstname = firstname
        
        guard let lastname = unarchiver.decodeObject(forKey: "lastname") as? String else { return nil }
        self.lastname = lastname
        
        guard let email = unarchiver.decodeObject(forKey: "email") as? String else { return nil }
        self.email = email
        
    }
}
