//
//  NotesCell.swift
//  Homework21
//
//  Created by Kato on 5/14/20.
//  Copyright © 2020 TBC. All rights reserved.
//

import UIKit

class NotesCell: UITableViewCell {

    @IBOutlet weak var noteLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
