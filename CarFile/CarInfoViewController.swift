//
//  CarInfoViewController.swift
//  CarFile
//
//  Created by Travis Siems on 10/18/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit

class CarInfoViewController: UIViewController {

    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var nextLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var locPurchasedLabel: UILabel!
    
    var carIndex: Int?
    var maintenanceIndex: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let maintenanceItem = carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!]
        
        lastLabel.text = maintenanceItem.last
        nextLabel.text = maintenanceItem.next
        typeLabel.text = maintenanceItem.type
        priceLabel.text = maintenanceItem.price
        locPurchasedLabel.text = maintenanceItem.locPurchased
        
        title = maintenanceItem.name

        // set colors of background, title bar, and text
        
        
        
//        let backItem = UIBarButtonItem(title: "Custom Text HERE", style: .Bordered, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
