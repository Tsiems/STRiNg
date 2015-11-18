//
//  AlertTableViewCell.swift
//  CarFile
//
//  Created by Travis Siems on 11/15/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit

class AlertTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nextLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
