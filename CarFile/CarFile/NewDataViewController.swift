//
//  NewDataViewController.swift
//  CarFile
//
//  Created by Travis Siems on 11/1/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit

class NewDataViewController: UIViewController {

    @IBOutlet weak var typeTextField: UITextField!
    
    @IBOutlet weak var lastDateButton: UIButton!
    @IBOutlet weak var nextDateButton: UIButton!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var whereTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Data"

        // Do any additional setup after loading the view.
        navigationController!.navigationBar.barTintColor = UIColor(red:0.09,green:0.55,blue:1.00,alpha: 1.00)
        
        let attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 28)!
        ]
        
        navigationController!.navigationBar.titleTextAttributes = attributes
        
        
        
        /////////////////////////////////////////////////
        /////////////////////////////////////////////////
        
        //Set dates for last and next dates
        
        //set date format
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        
        //get today's date
        let dateToday: NSDate = NSDate()
        
        //set last date to today
        let lastDateString = dateFormatter.stringFromDate(dateToday)
        lastDateButton.setTitle(lastDateString, forState: .Normal)
        
        
        //set next date to 6 months in the future
        let components: NSDateComponents = NSDateComponents()
        components.setValue(6, forComponent: NSCalendarUnit.Month)
        
        let nextDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: dateToday, options: NSCalendarOptions(rawValue: 0))!
        
        let nextDateString = dateFormatter.stringFromDate(nextDate)
        nextDateButton.setTitle(nextDateString, forState: .Normal)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "nextDateSegue" {
            // Get the new view controller using segue.destinationViewController.
            let navController = segue.destinationViewController as! UINavigationController
            
            let dateView = navController.viewControllers[0] as! DateViewController
            //get the row of the selected cell in the table
            
            // Pass the selected object to the new view controller.

            dateView.title = "Next"
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            dateFormatter.timeStyle = .NoStyle
            
            
            //dateView.datePicker.date = dateFormatter.dateFromString(nextDateButton.titleLabel!.text!)!
        }
        else if segue.identifier == "lastDateSegue" {
            // Get the new view controller using segue.destinationViewController.
            let navController = segue.destinationViewController as! UINavigationController
            
            let dateView = navController.viewControllers[0] as! DateViewController
            
            
            //get the row of the selected cell in the table
        
            // Pass the selected object to the new view controller.
            
            dateView.title = "Last"
            
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            dateFormatter.timeStyle = .NoStyle
            
            
            //dateView.datePicker.date = dateFormatter.dateFromString(lastDateButton.titleLabel!.text!)!
        }
        
        
    }
    
    
    @IBAction func doneChangingDate(segue: UIStoryboardSegue) {
        if segue.sourceViewController .isKindOfClass(DateViewController) {
            let source = segue.sourceViewController as! DateViewController
            if source.title == "Next" {
                nextDateButton.setTitle(source.dateLabel.text!, forState: .Normal)
                
            }
            else if source.title == "Last" {
                lastDateButton.setTitle(source.dateLabel.text!, forState: .Normal)
            }
        }
    }
    
    @IBAction func cancelChangingDate(segue: UIStoryboardSegue) {
        print( "cancel changing date" )
    }

}
