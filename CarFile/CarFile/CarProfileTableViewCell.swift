//
//  CarProfileTableViewCell.swift
//  CarFile
//
//  Created by Travis Siems on 11/27/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit

class CarProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!

    @IBOutlet weak var makeLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
