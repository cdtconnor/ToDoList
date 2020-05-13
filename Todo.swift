//
//  ToDo.swift
//  ToDoList
//
//  Created by Connor Thompson on 4/11/20.
//  Copyright © 2020 Connor Thompson. All rights reserved.
//

import Foundation

struct Todo {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
}

extension Todo {
    static func loadTodos() -> [Todo]? {
        if let todosfromdisk = storage.retrieve("todos.json", from: .documents, as: [Todo].self) {
            
        } else {
            return nil
        }
        
        
    
        }
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("todos")
    static func saveToDos(_ todos: [Todo]) {
        storage.store(todos, to: .documents, as: "todos.json")
    }
    
    
    
    
    
    static let dueDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    } ()

    static func loadSampleTodos() -> [Todo]? {
     
        print("load sample data")
        let todo1 = Todo(title: "Todo One", isComplete: false, dueDate: Date(), notes: "Notes 1")
     let todo2 = Todo(title: "Todo Two", isComplete: false, dueDate: Date(), notes: "Notes 2")
     let todo3 = Todo(title: "Todo Three", isComplete: false, dueDate: Date(), notes: "Notes 3")
        return [todo1, todo2, todo3]
}
}
