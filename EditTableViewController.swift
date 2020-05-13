//
//  EditTableViewController.swift
//  ToDoList
//
//  Created by Connor Thompson on 4/12/20.
//  Copyright © 2020 Connor Thompson. All rights reserved.
//

import UIKit

class EditTableViewController: UITableViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var saveOutlet: UIBarButtonItem!
   
    
    
    var todo: Todo?
    var isPickerHidden = true
    
    override func tableView(_ tableView: UITableView, heightForRowAt
    indexPath: IndexPath) -> CGFloat {
        let normalCellHeight = CGFloat(44)
        let largeCellHeight = CGFloat(200)
        
      switch(indexPath) {
        case [1,0]: //Due Date Cell
            print("due date cell")
            return isPickerHidden ? normalCellHeight :
            largeCellHeight
        case [2,0]: //Notes Cell
            print("notes cell")
            return largeCellHeight
        default: return normalCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt
    indexPath: IndexPath) {
        print("selected!")
        switch (indexPath) {
        case [1,0]:
            print("selected 2 0 !")
            isPickerHidden = !isPickerHidden
            dueDateLabel.textColor =
            isPickerHidden ? .black : tableView.tintColor
            tableView.beginUpdates()
            tableView.endUpdates()
        default: break
        }
    }


    
    
    
    
    
    

    @IBAction func unwindTodoList (segue: UIStoryboardSegue) {
        print("unwind")
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAndUnwind (segue: UIStoryboardSegue) {
        print("save and unwind")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if let todo = todo {
            navigationItem.title = "Todo"
            titleTextField.text = todo.title
            isCompleteButton.isSelected = todo.isComplete
            dueDatePickerView.date = todo.dueDate
            notesTextView.text = todo.notes

        } else {
        dueDatePickerView.date = Date().addingTimeInterval(20*60*60)
        }
       
        
        updateSaveButton()
        updateDueDateLabel(date: dueDatePickerView.date)
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
    Any?) {
        super.prepare(for: segue, sender: sender)
    
        guard segue.identifier == "saveUnwind" else { return }
    
        let title = titleTextField.text!
        let isComplete = isCompleteButton.isSelected
        let dueDate = dueDatePickerView.date
        let notes = notesTextView.text
        
        todo = Todo(title: title, isComplete: isComplete, dueDate:
        dueDate, notes: notes)
        
    }

  
    
    
    
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = Todo.dueDateFormatter.string(from: date)
    }
    
    @IBAction func datePickerChanged (_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date)
    }


    
    @IBAction func textEditChanged (sender: Any) {
        updateSaveButton()
    }
    
    @IBAction func returnedPressed (sender: Any) {
        titleTextField.resignFirstResponder()
    }
    
    
    
    
    func updateSaveButton() {
        let text = titleTextField.text ?? ""
        saveOutlet.isEnabled = !text.isEmpty
   }
   
    @IBAction func isCompleteButtonTapped(_ sender: Any) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected
    }




}
