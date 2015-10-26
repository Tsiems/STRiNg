//
//  CarTableViewCell.swift
//  CarFile
//
//  Created by Travis Siems on 10/15/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
