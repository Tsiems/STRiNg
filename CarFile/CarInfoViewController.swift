//
//  CarInfoViewController.swift
//  CarFile
//
//  Created by Travis Siems on 10/18/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit

class CarInfoViewController: UIViewController {


    @IBOutlet weak var lastField: UITextField!
    @IBOutlet weak var nextField: UITextField!
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
        notesField.sizeToFit()
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
        
        lastField.text = maintenanceItem.last
        nextField.text = maintenanceItem.next
        brandField.text = maintenanceItem.description
        priceField.text = maintenanceItem.price
        locPurchasedField.text = maintenanceItem.locPurchased
        notesField.text = maintenanceItem.notes
    }
    
    func updateData() {
        carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!].last = lastField.text
        carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!].next = nextField.text
        carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!].description = brandField.text
        carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!].price = priceField.text
        carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!].locPurchased = locPurchasedField.text
        carMgr.cars[carIndex!].maintenanceItems[maintenanceIndex!].notes = notesField.text
    }
    
    
    func disableTextEditting() {
        lastField.userInteractionEnabled = false
        lastField.borderStyle = UITextBorderStyle.None
        
        nextField.userInteractionEnabled = false
        nextField.borderStyle = UITextBorderStyle.None
        
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
        lastField.userInteractionEnabled = true
        lastField.borderStyle = UITextBorderStyle.RoundedRect
        
        nextField.userInteractionEnabled = true
        nextField.borderStyle = UITextBorderStyle.RoundedRect
        
        brandField.userInteractionEnabled = true
        brandField.borderStyle = UITextBorderStyle.RoundedRect
        
        priceField.userInteractionEnabled = true
        priceField.borderStyle = UITextBorderStyle.RoundedRect
        
        locPurchasedField.userInteractionEnabled = true
        locPurchasedField.borderStyle = UITextBorderStyle.RoundedRect
        
        notesField.userInteractionEnabled = true
        notesField.layer.borderWidth = 1.0
        notesField.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:1).CGColor
        
    }

    
    @IBAction func deleteButtonPressed(sender: AnyObject) {
        carMgr.cars[carIndex!].maintenanceItems.removeAtIndex(maintenanceIndex!)
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
