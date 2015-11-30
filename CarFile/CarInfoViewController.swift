//
//  CarInfoViewController.swift
//  CarFile
//
//  Created by Travis Siems on 10/18/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit
import CoreData

class CarInfoViewController: UIViewController {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeField: UITextField!

    @IBOutlet weak var lastDateButton: UIButton!
    @IBOutlet weak var nextDateButton: UIButton!

    @IBOutlet weak var brandField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var locPurchasedField: UITextField!
    @IBOutlet weak var notesField: UITextView!


    @IBOutlet weak var deleteButton: UIButton!
    
    var carIndex: Int?
    var maintenanceIndex: Int?
    
    
    var leftBarItem: UIBarButtonItem?
    var rightBarItem: UIBarButtonItem?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let maintenanceItem = maintenanceItems[maintenanceIndex!]
        
        deleteButton.hidden = true
        placeData()
        
        disableTextEditting()
        

        leftBarItem = navigationItem.leftBarButtonItem
        rightBarItem = navigationItem.rightBarButtonItem
        
        //set title
        title = maintenanceItem.valueForKey("type") as? String
    }
    
    override func viewDidLayoutSubviews() {
        
        //size the notesField as needed to fit all the text
        //notesField.numberOfLines = 0
//        notesField.sizeToFit()
        
        let notesMaxHeight = 150
        let notesWidth = locPurchasedField.frame.width
        
        notesField.frame.size.width = CGFloat(notesWidth)
        notesField.frame.size.height = CGFloat(notesMaxHeight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editButtonPressed(sender: AnyObject) {
        enableTextEditting()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneButtonPressed:")
        navigationItem.rightBarButtonItem = doneBtn
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelButtonPressed:")
        navigationItem.leftBarButtonItem = cancelBtn
        
        deleteButton.hidden = false
        
        
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        //reset bar items
        navigationItem.rightBarButtonItem = rightBarItem
        navigationItem.leftBarButtonItem = leftBarItem
        
        placeData()
        
        disableTextEditting()
        
        deleteButton.hidden = true
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.typeField.text = self.typeField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if self.typeField.text != "" {
            //reset bar items
            navigationItem.rightBarButtonItem = rightBarItem
            navigationItem.leftBarButtonItem = leftBarItem
            
            updateData()
            disableTextEditting()
            
            deleteButton.hidden = true
        }
        else {
            let invalidFieldsAlert = UIAlertController(title: "Done Editing Data", message: "The data must have a type.", preferredStyle: UIAlertControllerStyle.Alert)
            
            
            invalidFieldsAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                //do nothing
            }))
            
            
            presentViewController(invalidFieldsAlert, animated: true, completion: nil)
        }
    }
    
    
    func placeData() {
        let maintenanceItem = maintenanceItems[maintenanceIndex!]
        
        typeField.text = maintenanceItem.valueForKey("type") as? String
        lastDateButton.setTitle(maintenanceItem.valueForKey("lastDate") as? String, forState: .Normal)
        nextDateButton.setTitle(maintenanceItem.valueForKey("nextDate") as? String, forState: .Normal)
        brandField.text = maintenanceItem.valueForKey("brand") as? String
        priceField.text = maintenanceItem.valueForKey("price") as? String
        locPurchasedField.text = maintenanceItem.valueForKey("locPurchased") as? String
        notesField.text = maintenanceItem.valueForKey("notes") as? String
    }
    
    func updateData() {
        
        maintenanceItems[maintenanceIndex!].setValue(typeField.text, forKey: "type")
        self.title = typeField.text //update the view title
        
        maintenanceItems[maintenanceIndex!].setValue(lastDateButton.titleLabel?.text, forKey: "lastDate")
        maintenanceItems[maintenanceIndex!].setValue(nextDateButton.titleLabel?.text, forKey: "nextDate")
        maintenanceItems[maintenanceIndex!].setValue(brandField.text, forKey: "brand" )
        maintenanceItems[maintenanceIndex!].setValue(priceField.text, forKey: "price" )
        maintenanceItems[maintenanceIndex!].setValue(locPurchasedField.text, forKey: "locPurchased")
        maintenanceItems[maintenanceIndex!].setValue(notesField.text, forKey: "notes")
        
        
        //save in persistent data
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.saveContext()
    }
    
    
    func disableTextEditting() {
        typeLabel.hidden = true
        typeField.hidden = true
        
        lastDateButton.userInteractionEnabled = false
        lastDateButton.layer.borderWidth = 0
        lastDateButton.contentHorizontalAlignment = .Left
        lastDateButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        nextDateButton.userInteractionEnabled = false
        nextDateButton.layer.borderWidth = 0
        nextDateButton.contentHorizontalAlignment = .Left
        nextDateButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        brandField.userInteractionEnabled = false
        brandField.borderStyle = UITextBorderStyle.None
        
        priceField.userInteractionEnabled = false
        priceField.borderStyle = UITextBorderStyle.None
        
        locPurchasedField.userInteractionEnabled = false
        locPurchasedField.borderStyle = UITextBorderStyle.None
        
        notesField.userInteractionEnabled = false
        notesField.layer.borderWidth = 0.0
        notesField.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:1).CGColor
        
        
        deleteButton.hidden = true
    }
    
    func enableTextEditting() {
        typeLabel.hidden = false
        typeField.hidden = false
        typeField.userInteractionEnabled = true
        typeField.borderStyle = UITextBorderStyle.RoundedRect
        
        lastDateButton.userInteractionEnabled = true
        lastDateButton.layer.cornerRadius = 5
        lastDateButton.layer.borderWidth = 0.1
        lastDateButton.contentHorizontalAlignment = .Center
        lastDateButton.setTitleColor( UIColor(red:0, green:0.48, blue:1, alpha:1) , forState: .Normal)
        
        nextDateButton.userInteractionEnabled = true
        nextDateButton.layer.cornerRadius = 5
        nextDateButton.layer.borderWidth = 0.1
        nextDateButton.contentHorizontalAlignment = .Center
        nextDateButton.setTitleColor( UIColor(red:0, green:0.48, blue:1, alpha:1) , forState: .Normal)
        
        brandField.userInteractionEnabled = true
        brandField.borderStyle = UITextBorderStyle.RoundedRect
        
        priceField.userInteractionEnabled = true
        priceField.borderStyle = UITextBorderStyle.RoundedRect
        
        locPurchasedField.userInteractionEnabled = true
        locPurchasedField.borderStyle = UITextBorderStyle.RoundedRect
        
        notesField.userInteractionEnabled = true
        notesField.layer.borderWidth = 0.1
        notesField.layer.cornerRadius = 5
        notesField.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:1).CGColor
    }

    
    @IBAction func deleteButtonPressed(sender: AnyObject) {
        let deleteAlert = UIAlertController(title: "Delete Item", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
        
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            //do nothing
        }))
        
        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .Destructive, handler: { (action: UIAlertAction!) in
            self.deleteThisItem()
            
            //exit this view (the car is gone)
            self.performSegueWithIdentifier("cancelNewDataSegue", sender: sender)
        }))
        
        
        presentViewController(deleteAlert, animated: true, completion: nil)
    }
    
    func deleteThisItem() {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        managedContext.deleteObject(maintenanceItems[maintenanceIndex!] as NSManagedObject)
        maintenanceItems.removeAtIndex(maintenanceIndex!)
        
        appDelegate.saveContext()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "editNextDateSegue" {
            // Get the new view controller using segue.destinationViewController.
            let navController = segue.destinationViewController as! UINavigationController
            
            let dateView = navController.viewControllers[0] as! DateViewController
            
            
            dateView.title = "Next"
            dateView.newOrEdit = "Edit"
            
            let dateFormatter = NSDateFormatter()
           //dateFormatter.dateStyle = .ShortStyle
            dateFormatter.timeStyle = .NoStyle
            dateFormatter.dateFormat = "MM/dd/yy"
            
            if let nextLabel = nextDateButton.titleLabel {
                if let nextLabelText = nextLabel.text {
                    dateView.initialDate = dateFormatter.dateFromString(nextLabelText)!
                }
            }
        }
        else if segue.identifier == "editLastDateSegue" {
            // Get the new view controller using segue.destinationViewController.
            let navController = segue.destinationViewController as! UINavigationController
            
            let dateView = navController.viewControllers[0] as! DateViewController
            
            
            dateView.title = "Last"
            dateView.newOrEdit = "Edit"
            
            
            let dateFormatter = NSDateFormatter()
            //dateFormatter.dateStyle = .ShortStyle
            dateFormatter.timeStyle = .NoStyle
            dateFormatter.dateFormat = "MM/dd/yy"
            
            
            dateView.initialDate = dateFormatter.dateFromString(lastDateButton.titleLabel!.text!)!
        }
    }
    
    
    @IBAction func doneChangingDate(segue: UIStoryboardSegue) {
        if segue.sourceViewController .isKindOfClass(DateViewController) {
            let source = segue.sourceViewController as! DateViewController
            if source.newOrEdit == "Edit" {
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
