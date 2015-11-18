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
        
        
        //Format date buttons
        lastDateButton.layer.cornerRadius = 5
        lastDateButton.layer.borderWidth = 0.1
        lastDateButton.contentHorizontalAlignment = .Center
        
        nextDateButton.layer.cornerRadius = 5
        nextDateButton.layer.borderWidth = 0.1
        nextDateButton.contentHorizontalAlignment = .Center
        
        
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
            

            dateView.title = "Next"
            dateView.newOrEdit = "New"
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            dateFormatter.timeStyle = .NoStyle
            
            
            dateView.initialDate = dateFormatter.dateFromString(nextDateButton.titleLabel!.text!)!
        }
        else if segue.identifier == "lastDateSegue" {
            // Get the new view controller using segue.destinationViewController.
            let navController = segue.destinationViewController as! UINavigationController
            
            let dateView = navController.viewControllers[0] as! DateViewController
            
            
            dateView.title = "Last"
            dateView.newOrEdit = "New"
            
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            dateFormatter.timeStyle = .NoStyle
            
            
            dateView.initialDate = dateFormatter.dateFromString(lastDateButton.titleLabel!.text!)!
        }
        
        
    }
    
    
    @IBAction func doneChangingDate(segue: UIStoryboardSegue) {
        if segue.sourceViewController .isKindOfClass(DateViewController) {
            let source = segue.sourceViewController as! DateViewController
            if source.newOrEdit == "New" {
                if source.title == "Next" {
                    nextDateButton.setTitle(source.dateLabel.text!, forState: .Normal)
                    
                }
                else if source.title == "Last" {
                    lastDateButton.setTitle(source.dateLabel.text!, forState: .Normal)
                }
            }
        }
    }
    
    @IBAction func cancelChangingDate(segue: UIStoryboardSegue) {
        print( "cancel changing date" )
    }

}
