//
//  CarInfoViewController.swift
//  CarFile
//
//  Created by Travis Siems on 10/18/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit

class CarInfoViewController: UIViewController {

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
        
        let maintenanceItem = carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!]
        
        deleteButton.hidden = true
        placeData()
        
        disableTextEditting()
        

        
        
        
        
        leftBarItem = navigationItem.leftBarButtonItem
        rightBarItem = navigationItem.rightBarButtonItem
        
        
        title = maintenanceItem.type
    
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
        navigationItem.rightBarButtonItem = rightBarItem
        navigationItem.leftBarButtonItem = leftBarItem
        
        placeData()
        
        disableTextEditting()
        
        deleteButton.hidden = true
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        navigationItem.rightBarButtonItem = rightBarItem
        navigationItem.leftBarButtonItem = leftBarItem
        
        updateData()
        disableTextEditting()
        
        deleteButton.hidden = true
        
    }
    
    
    
    func placeData() {
        let maintenanceItem = carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!]
        
        lastDateButton.setTitle(maintenanceItem.last, forState: .Normal)
        nextDateButton.setTitle(maintenanceItem.next, forState: .Normal)
        brandField.text = maintenanceItem.description
        priceField.text = maintenanceItem.price
        locPurchasedField.text = maintenanceItem.locPurchased
        notesField.text = maintenanceItem.notes
    }
    
    func updateData() {
        carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!].last = lastDateButton.titleLabel?.text
        carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!].next = nextDateButton.titleLabel?.text
        carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!].description = brandField.text
        carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!].price = priceField.text
        carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!].locPurchased = locPurchasedField.text
        carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!].notes = notesField.text
    }
    
    
    func disableTextEditting() {
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
        carMgr.cars[carIndex!].maintenanceItems.removeAtIndex(maintenanceIndex!)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "editNextDateSegue" {
            // Get the new view controller using segue.destinationViewController.
            let navController = segue.destinationViewController as! UINavigationController
            
            let dateView = navController.viewControllers[0] as! DateViewController
            
            
            dateView.title = "Next"
            dateView.newOrEdit = "Edit"
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateStyle = .ShortStyle
            dateFormatter.timeStyle = .NoStyle
            
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
            dateFormatter.dateStyle = .ShortStyle
            dateFormatter.timeStyle = .NoStyle
            
            
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
