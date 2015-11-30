//
//  NewCarViewController.swift
//  CarFile
//
//  Created by Travis Siems on 11/1/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit
import Foundation
import SwiftHTTP
import CoreData

class NewCarViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var populateVinButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var populateVinTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var vinNumTextField: UITextField!
    @IBOutlet weak var licNumTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    var styleID: String?
    
    var newCar: Bool?
    var carIndex: Int?
    
    
    var leftBarItem: UIBarButtonItem?
    var rightBarItem: UIBarButtonItem?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldDelegates()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name:UIKeyboardWillHideNotification, object: nil)
        
        
        self.styleID = ""
        
        //        let backItem = UIBarButtonItem(title: "cancel", style: .Plain, target: nil, action: nil)
        //        navigationItem.backBarButtonItem = backItem
        
        if newCar == true
        {
            prepareNewCar()
        }
        else
        {
            prepareExistingCar()
        }
        
        navigationController!.navigationBar.barTintColor = UIColor(red:0.09,green:0.55,blue:1.00,alpha: 1.00)
        
        let attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 28)!
        ]
        
        navigationController!.navigationBar.titleTextAttributes = attributes
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let width = UIScreen.mainScreen().bounds.size.width
        let height = UIScreen.mainScreen().bounds.size.height
        scrollView.contentSize = CGSizeMake(width, height)
        
        scrollView.scrollEnabled = true
        
        //scroll to top
        self.scrollView.setContentOffset(CGPoint(x:0,y:0), animated: false)
    }
    
    func prepareNewCar() {
        title = "New Car"
        
        enableTextEditting()
        
        //set the bar items
        let leftButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelToCarMenu:")
        let rightButton = UIBarButtonItem(title: "Save", style: .Done, target: self, action: "saveToCarMenu:")
        leftButton.tintColor = UIColor.whiteColor()
        rightButton.tintColor = UIColor.whiteColor()
        
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
        
        //save these in case they change
        leftBarItem = self.navigationItem.leftBarButtonItem
        rightBarItem = self.navigationItem.rightBarButtonItem
    }
    
    func prepareExistingCar() {
        
        enableTextEditting()
        
        populateFields()
        
        disableTextEditting()
        
        //set the right button time
        let rightButton = UIBarButtonItem(title: "Edit", style: .Done, target: self, action: "editButtonPressed:")
        rightButton.tintColor = UIColor.whiteColor()

        self.navigationItem.rightBarButtonItem = rightButton
        
        //save these in case they change
        leftBarItem = self.navigationItem.leftBarButtonItem
        rightBarItem = self.navigationItem.rightBarButtonItem
    }
    
    func populateFields() {
        title = cars[carIndex!].valueForKey("name") as? String
        nameTextField.text = title
        makeTextField.text = cars[carIndex!].valueForKey("make") as? String
        modelTextField.text = cars[carIndex!].valueForKey("model") as? String
        yearTextField.text = cars[carIndex!].valueForKey("year") as? String
        colorTextField.text = cars[carIndex!].valueForKey("color") as? String
        priceTextField.text = cars[carIndex!].valueForKey("price") as? String
        vinNumTextField.text = cars[carIndex!].valueForKey("vinNum") as? String
        licNumTextField.text = cars[carIndex!].valueForKey("licNum") as? String
        notesTextField.text = cars[carIndex!].valueForKey("notes") as? String
    }
    
    func updateData() {
        cars[carIndex!].setValue(nameTextField.text, forKey: "name")
        cars[carIndex!].setValue(makeTextField.text, forKey: "make")
        cars[carIndex!].setValue(modelTextField.text, forKey: "model")
        cars[carIndex!].setValue(yearTextField.text, forKey: "year")
        cars[carIndex!].setValue(colorTextField.text, forKey: "color")
        cars[carIndex!].setValue(priceTextField.text, forKey: "price")
        cars[carIndex!].setValue(vinNumTextField.text, forKey: "vinNum")
        cars[carIndex!].setValue(licNumTextField.text, forKey: "licNum")
        cars[carIndex!].setValue(notesTextField.text, forKey: "notes")
        
        //save in persistent store
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.saveContext()
        
        
        //populateFields() //not really needed, just the title
        
        title = nameTextField.text
    }
    
    func cancelToCarMenu(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("cancelToMenuSegue", sender: sender)
    }
    
    func saveToCarMenu(sender: UIBarButtonItem) {
        self.nameTextField.text = self.nameTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if self.nameTextField.text != "" {
            self.performSegueWithIdentifier("saveToMenuSegue", sender: sender)
        }
        else {
            let invalidFieldsAlert = UIAlertController(title: "Save Car", message: "The car must have a name.", preferredStyle: UIAlertControllerStyle.Alert)
            
            
            invalidFieldsAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                //do nothing
            }))
            
            
            presentViewController(invalidFieldsAlert, animated: true, completion: nil)
        }
    }
    
    func editButtonPressed(sender: UIBarButtonItem) {
        
        enableTextEditting()
        
        //set the bar items
        let leftButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "cancelButtonPressed")
        let rightButton = UIBarButtonItem(title: "Save", style: .Done, target: self, action: "saveButtonPressedForUpdate")
        leftButton.tintColor = UIColor.whiteColor()
        rightButton.tintColor = UIColor.whiteColor()
        
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func cancelButtonPressed() {
        disableTextEditting()
        resetBarItems()
    }
    
    func saveButtonPressedForUpdate() {
        self.nameTextField.text = self.nameTextField.text!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if self.nameTextField.text != "" {
            updateData()
            disableTextEditting()
            resetBarItems()
        }
        else {
            let invalidFieldsAlert = UIAlertController(title: "Save Car", message: "The car must have a name.", preferredStyle: UIAlertControllerStyle.Alert)
            
            
            invalidFieldsAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                //do nothing
            }))
            
            
            presentViewController(invalidFieldsAlert, animated: true, completion: nil)
        }

    }
    
    @IBAction func deleteButtonPressed(sender: AnyObject) {
        
        let deleteAlert = UIAlertController(title: "Delete Car", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
        
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: { (action: UIAlertAction!) in
            //do nothing
        }))
        
        deleteAlert.addAction(UIAlertAction(title: "Ok", style: .Destructive, handler: { (action: UIAlertAction!) in
            self.deleteThisCar(sender)
            
            //exit this view (the car is gone)
            self.performSegueWithIdentifier("cancelToMenuSegue", sender: sender)
        }))
        
        
        presentViewController(deleteAlert, animated: true, completion: nil)
    }
    
    func deleteThisCar(sender: AnyObject) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let thisCarID = cars[carIndex!].valueForKey("id") as? Int
        
        
        
        for i in 0...maintenanceItems.count-1
        {
            if maintenanceItems[i].valueForKey("carID") as? Int == thisCarID
            {
                managedContext.deleteObject(maintenanceItems[i] as NSManagedObject)
            }
        }
        
        //delete the car
        managedContext.deleteObject(cars[carIndex!] as NSManagedObject)
        cars.removeAtIndex(carIndex!)
        
        appDelegate.saveContext()

    }
    
    
    func resetBarItems() {
        self.navigationItem.leftBarButtonItem = self.leftBarItem
        self.navigationItem.rightBarButtonItem = self.rightBarItem
    }
    
    func disableTextEditting() {
        populateVinTextField.hidden = true
        populateVinButton.hidden = true
        nameTextField.hidden = true
        nameLabel.hidden = true
        
        populateVinTextField.userInteractionEnabled = false
        nameTextField.userInteractionEnabled = false
        
        makeTextField.userInteractionEnabled = false
        makeTextField.borderStyle = UITextBorderStyle.None
        
        modelTextField.userInteractionEnabled = false
        modelTextField.borderStyle = UITextBorderStyle.None
        
        yearTextField.userInteractionEnabled = false
        yearTextField.borderStyle = UITextBorderStyle.None
        
        colorTextField.userInteractionEnabled = false
        colorTextField.borderStyle = UITextBorderStyle.None
        
        priceTextField.userInteractionEnabled = false
        priceTextField.borderStyle = UITextBorderStyle.None
        
        vinNumTextField.userInteractionEnabled = false
        vinNumTextField.borderStyle = UITextBorderStyle.None
        
        licNumTextField.userInteractionEnabled = false
        licNumTextField.borderStyle = UITextBorderStyle.None
        
        notesTextField.userInteractionEnabled = false
        notesTextField.borderStyle = UITextBorderStyle.None
        
        
        deleteButton.hidden = true
    }
    
    func enableTextEditting() {
        populateVinTextField.hidden = false
        populateVinButton.hidden = false
        nameTextField.hidden = false
        nameLabel.hidden = false
        
        populateVinTextField.userInteractionEnabled = true
        nameTextField.userInteractionEnabled = true
        
        
        makeTextField.userInteractionEnabled = true
        makeTextField.borderStyle = UITextBorderStyle.RoundedRect
        
        modelTextField.userInteractionEnabled = true
        modelTextField.borderStyle = UITextBorderStyle.RoundedRect
        
        yearTextField.userInteractionEnabled = true
        yearTextField.borderStyle = UITextBorderStyle.RoundedRect
        
        colorTextField.userInteractionEnabled = true
        colorTextField.borderStyle = UITextBorderStyle.RoundedRect
        
        priceTextField.userInteractionEnabled = true
        priceTextField.borderStyle = UITextBorderStyle.RoundedRect
        
        vinNumTextField.userInteractionEnabled = true
        vinNumTextField.borderStyle = UITextBorderStyle.RoundedRect
        
        licNumTextField.userInteractionEnabled = true
        licNumTextField.borderStyle = UITextBorderStyle.RoundedRect
        
        notesTextField.userInteractionEnabled = true
        notesTextField.borderStyle = UITextBorderStyle.RoundedRect
        
        if newCar == false {
            deleteButton.hidden = false
        }
        else {
            deleteButton.hidden = true
        }
    }
    
    @IBAction func populateVin(sender: AnyObject) {
        
        //Steven's Car VIN (Not Case Sensitive): 1FADP3L9XFL256135
        
        var vin = ""
        vin = populateVinTextField.text!
        self.view.window?.endEditing(true)
        populateVinTextField.text="";
        if vin.characters.count == 17
        {
            let urlString = "https://api.edmunds.com/api/vehicle/v2/vins/" + vin + "?fmt=json&api_key=5zyd8sa5k3yxgpcg7t49agav"
            if let url = NSURL(string: urlString)
            {
                if let data = try? NSData(contentsOfURL: url, options: [])
                {
                    let json = JSON(data: data)
                    
                    if json["make"]["id"].intValue > 0
                    {
                        //let id = json["make"]["id"].intValue
                        let makeName = json["make"]["name"].stringValue
                        let modelName = json["model"]["name"].stringValue
                        let yearName = json["years"][0]["year"].stringValue
                        let colorName = json["colors"][1]["options"][0]["name"].stringValue
                        let priceName = json["price"]["baseMSRP"].stringValue
                        let vinName = json["vin"].stringValue
                        let styleID = json["years"][0]["styles"][0]["id"].stringValue
                        let obj = ["makeName": makeName, "modelName": modelName, "yearName": yearName, "colorName": colorName, "priceName": priceName, "vinName": vinName, "styleID": styleID]
                        setObject(obj)
                    }
                    else
                    {
                        print("You got an error")
                    }
                }
            }
        }
        else
        {
            print("Please enter a valid VIN")
        }
    } // END of Populate Button Function
    
    
    func setObject(obj:[String:String])
    {
        self.makeTextField.text = obj["makeName"]
        self.modelTextField.text = obj["modelName"]
        self.yearTextField.text = obj["yearName"]
        self.colorTextField.text = obj["colorName"]
        self.priceTextField.text = obj["priceName"]
        self.vinNumTextField.text = obj["vinName"]
        self.styleID = obj["styleID"]
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        let nextTage=textField.tag+1;
        // Try to find next responder
        let nextResponder=textField.superview?.viewWithTag(nextTage) as UIResponder!
        
        if (nextResponder != nil){
            // Found next responder, so set it.
            nextResponder?.becomeFirstResponder()
        }
        else
        {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }
        return false // We do not want UITextField to insert line-breaks.
    }
    
    func setTextFieldDelegates() {
        self.populateVinTextField.delegate = self
        self.nameTextField.delegate = self
        self.makeTextField.delegate = self
        self.modelTextField.delegate = self
        self.yearTextField.delegate = self
        self.colorTextField.delegate = self
        self.priceTextField.delegate = self
        self.vinNumTextField.delegate = self
        self.licNumTextField.delegate = self
        self.notesTextField.delegate = self
    }

    func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        keyboardFrame = self.view.convertRect(keyboardFrame, fromView: nil)
        
        
        scrollView.scrollEnabled = true
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollView.contentInset = contentInset
        
        //scrollView.scrollEnabled = false
    }
    
    func keyboardWillHide(notification:NSNotification){
        
        scrollView.scrollEnabled = true
        
        self.scrollView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        
        scrollView.scrollEnabled = false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        //put stuff to save textfield's text
    }
    
    
}
