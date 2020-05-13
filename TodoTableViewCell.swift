//
//  TodoTableViewCell.swift
//  ToDoList
//
//  Created by Connor Thompson on 4/13/20.
//  Copyright © 2020 Connor Thompson. All rights reserved.
//

import UIKit

@objc protocol ToDoCellDeleagte: class {
    func checkmarkTapped(sender: TodoTableViewCell)
}

class TodoTableViewCell: UITableViewCell {
    @IBOutlet weak var checkmarkButton: UIButton!
    @IBOutlet weak var titleField: UITextField!
    @IBAction func completeButtonTapped(_ sender: Any) {
   
    
    
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
