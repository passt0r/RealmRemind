//
//  ListedTaskItemTableViewCell.swift
//  RealmTest
//
//  Created by Dmytro Pasinchuk on 05.03.17.
//  Copyright © 2017 Dmytro Pasinchuk. All rights reserved.
//

import UIKit

class ListedTaskItemTableViewCell: UITableViewCell {
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var taskIsDone: UIImageView!
    @IBOutlet weak var isDoneLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
