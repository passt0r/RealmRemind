//
//  ListedTaskTableViewCell.swift
//  RealmTest
//
//  Created by Dmytro Pasinchuk on 05.03.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit

class ListedTaskTableViewCell: UITableViewCell {
    @IBOutlet weak var taskListName: UILabel!
    @IBOutlet weak var tasksLeft: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
