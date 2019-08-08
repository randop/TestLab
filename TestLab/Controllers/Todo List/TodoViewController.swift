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
    
    @IBOutlet weak var todosTable: UITableView!
    @IBAction func addTap(_ sender: Any) {
        addTodoAction()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTodos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTodos() {
        todos = DB.getTodos()
    }
    
    func addTodoAction() {
        let alert = UIAlertController(title: "Add Todo", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter Todo:"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            if let textField = alert?.textFields![0].trimmedText {
                if textField.count > 0 {
                    self.todosTable.scrollToBottom()
                    if let newID = self.DB.addTodo(value: textField) {
                        self.todos.append(Todo(id: newID, value: textField, done: false))
                        self.todosTable.beginUpdates()
                        let indexPath = IndexPath(item: self.todos.count - 1, section: 0)
                        self.todosTable.insertRows(at: [indexPath], with: .right)
                        self.todosTable.endUpdates()
                    }
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: false, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        if todos[indexPath.row].done {
            let strokeEffect: [NSAttributedStringKey : Any] = [
                NSAttributedStringKey.strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue,
                NSAttributedStringKey.strikethroughColor: UIColor.red,
                NSAttributedStringKey.foregroundColor: UIColor.gray
            ]
            cell.textLabel?.attributedText = NSAttributedString(string: todos[indexPath.row].value, attributes: strokeEffect)
        } else {
            cell.textLabel?.text = todos[indexPath.row].value
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        todos[indexPath.row].done = !todos[indexPath.row].done
        DB.updateTodoDone(id: todos[indexPath.row].id, isDone: todos[indexPath.row].done)
        todosTable.reloadRows(at: [indexPath], with: .right)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //void
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath)  in
            self.todosTable.beginUpdates()
            self.DB.deleteTodo(id: self.todos[indexPath.row].id)
            self.todos.remove(at: indexPath.row)
            self.todosTable.deleteRows(at: [indexPath], with: .none)
            self.todosTable.endUpdates()
        }
        return [deleteAction]
    }
}
