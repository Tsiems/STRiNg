//
//  DateViewController.swift
//  CarFile
//
//  Created by Travis Siems on 11/13/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var initialDate : NSDate?
    var newOrEdit : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        datePicker.addTarget(self, action: Selector("datePickerChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        
        if let _ = initialDate {
            datePicker.setDate(initialDate!, animated: true)
        }

        
        datePickerChanged(datePicker)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func datePickerChanged(datePicker:UIDatePicker) {
        let dateFormatter = NSDateFormatter()
        
        //dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateFormatter.dateFormat = "MM/dd/yy"
        
        let strDate = dateFormatter.stringFromDate(datePicker.date)
        dateLabel.text = strDate
    }
    
    



}
