//
//  DAO.swift
//  TestLab
//
//  Created by Randolph on 8/5/19.
//  Copyright © 2019 Randolph. All rights reserved.
//

import Foundation
import SQLite

class DAO {
    static let instance = DAO()
    private let db: Connection?
    
    private let qrsTable = Table("qrs")
    private let todosTable = Table("todos")
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            db = try Connection("\(path)/db.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        createTables()
    }
    
    func createTables() {
        //createUserTable()
        createQrTable()
        createTodosTable()
    }
    
    func createUserTable() {
        let users = Table("users")
        let id = Expression<Int64>("id")
        let name = Expression<String?>("name")
        let email = Expression<String>("email")
        
        do {
            try db?.run(users.create { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(email, unique: true)
            })
        } catch {
            //print("Failed to create or already created")
        }
    }
    
    func createQrTable() {
        let id = Expression<Int64>("id")
        let value = Expression<String?>("value")
        
        do {
            try db?.run(self.qrsTable.create { t in
                t.column(id, primaryKey: true)
                t.column(value)
            })
        } catch {
            //print("Failed to create or already created")
        }
    }
    
    func createTodosTable() {
        let id = Expression<Int64>("id")
        let value = Expression<String>("value")
        let done = Expression<Bool>("done")
        
        do {
            try db?.run(self.todosTable.create { t in
                t.column(id, primaryKey: true)
                t.column(value)
                t.column(done)
            })
        } catch {
            //print("Failed to create or already created")
        }
    }
    
    func addQr(value aValue: String) -> Int64? {
        let value = Expression<String?>("value")
        do {
            let insert = self.qrsTable.insert(value <- aValue)
            let id = try db!.run(insert)
            return id
        } catch {
            print("Insert QR failed")
            return -1
        }
    }
    
    func addTodo(value aValue: String) -> Int64? {
        let value = Expression<String>("value")
        let done = Expression<Bool>("done")
        
        do {
            let insert = self.todosTable.insert(value <- aValue, done <- false)
            let id = try db!.run(insert)
            return id
        } catch {
            print("Insert Todo failed")
            return -1
        }
    }
    
    func updateTodoDone(id theID: Int64, isDone: Bool) {
        let id = Expression<Int64>("id")
        let done = Expression<Bool>("done")
        do {
            let todo = self.todosTable.filter(id == theID)
            try db!.run(todo.update(done <- isDone))
        } catch {
            //failed
        }
    }
    
    func deleteTodo(id theID: Int64) {
        let id = Expression<Int64>("id")
        do {
            let todo = self.todosTable.filter(id == theID)
            try db!.run(todo.delete())
        } catch {
            //failed
        }
    }
    
    func getQrs() -> [QR] {
        var qrs = [QR]()
        let id = Expression<Int64>("id")
        let value = Expression<String?>("value")
        let orderDescById = Expression<String?>("id").desc
        
        do {
            for qr in try db!.prepare(self.qrsTable.order( orderDescById )) {
                qrs.append(QR(id: qr[id], value: qr[value]!))
            }
        } catch {
            //print("Select failed")
        }
        return qrs
    }
    
    func getTodos() -> [Todo] {
        var todos = [Todo]()
        let id = Expression<Int64>("id")
        let value = Expression<String>("value")
        let done = Expression<Bool>("done")
        
        do {
            for todo in try db!.prepare(self.todosTable) {
                todos.append(Todo(id: todo[id], value: todo[value], done: todo[done]))
            }
        } catch {
            print("Select failed")
        }
        return todos
    }
}
