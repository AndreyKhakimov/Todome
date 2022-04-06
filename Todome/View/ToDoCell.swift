//
//  ToDoCell.swift
//  Todome
//
//  Created by Andrey Khakimov on 30.03.2022.
//

import UIKit

class ToDoCell: UITableViewCell {

    @IBOutlet weak var toDoTextLabel: UILabel!
    @IBOutlet weak var rightImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(task: String, isComplete: Bool) {
        toDoTextLabel.text = task
        setIsCompleted(isComplete, animated: true)
    }
    
    func setIsCompleted(_ value: Bool, animated: Bool) {
        rightImage.image = value ? UIImage(systemName: "checkmark.circle") :
            UIImage(systemName: "plus")
    }
    
}
