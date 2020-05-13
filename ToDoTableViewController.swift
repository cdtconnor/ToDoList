//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Connor Thompson on 4/11/20.
//  Copyright © 2020 Connor Thompson. All rights reserved.
//

import UIKit


class ToDoTableViewController: UITableViewController, ToDoCellDeleagte {
    func checkmarkTapped(sender: TodoTableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var todo = todos[indexPath.row]
            todo.isComplete = !todo.isComplete
            todos[indexPath.row] = todo
            tableView.reloadRows(at: [indexPath], with: .automatic)
            Storage.store(todos, to: .documents, as: "todos.json")
        }
    }
    

   
   
    //var todos: [Todo] = []()
    // Should be either:
    // var todos: [Todo] = []
    // or
    var todos = [Todo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem

        if let savedToDo = Todo.loadTodos() {
            print("todos exist")
            todos = savedToDo
        } else {
            print("create blank todos and save to device")
            Storage.store(todos, to: .documents, as: "todos.json")
        }
                
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        print("test")
        
        
        
        //guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCellID", for: indexPath) else {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCellID") as? TodoTableViewCell else {
            fatalError("Could not dequeu a cell")
        }

        let todo = todos[indexPath.row]
       // cell.textLabel?.text = todo.title
        cell.delegate = self
        cell.titleField.text = todo.title
        cell.checkmarkButton.isSelected = todo.isComplete
        return cell
    }
    

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Todo.saveToDos(todos)
        } else if editingStyle == .insert {
            
        }    
    }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetails" {
        let todoViewController = segue.destination as!
        EditTableViewController
        let indexPath = tableView.indexPathForSelectedRow!
        let selectedTodo = todos[indexPath.row]
        todoViewController.todo = selectedTodo
    }
    }
    
    
    
    
    
    
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! EditTableViewController
        if let todo = sourceViewController.todo {  let newIndexPath = IndexPath(row: todos.count,
                    section: 0)
            
                    todos.append(todo)
                    tableView.insertRows(at: [newIndexPath],
                    with: .automatic)
                }
        Todo.saveToDos(todos)
    
    }
            

           


    
    
    
    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
