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

class NewCarViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
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
                        let obj = ["makeName": makeName, "modelName": modelName, "yearName": yearName, "colorName": colorName, "priceName": priceName, "vinName": vinName]
                        foo(obj)
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
    
    
    func foo(obj:[String:String])
    {
        self.makeTextField.text = obj["makeName"];
        self.modelTextField.text = obj["modelName"];
        self.yearTextField.text = obj["yearName"];
        self.colorTextField.text = obj["colorName"];
        self.priceTextField.text = obj["priceName"];
        self.vinNumTextField.text = obj["vinName"];
    }
    
    func textFieldShouldReturn(userTextField: UITextField!) -> Bool {
        userTextField.resignFirstResponder()
        return true;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        //        let backItem = UIBarButtonItem(title: "cancel", style: .Plain, target: nil, action: nil)
        //        navigationItem.backBarButtonItem = backItem
        
        title = "New Car"
        navigationController!.navigationBar.barTintColor = UIColor(red:0.09,green:0.55,blue:1.00,alpha: 1.00)
        
        let attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 28)!
        ]
        
        navigationController!.navigationBar.titleTextAttributes = attributes
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    @IBAction func cancelToMenu(segue:UIStoryboardSegue) {
    //        print("Hello! Cancel")
    //
    //    }
    //
    //    @IBAction func saveToMenu(segue:UIStoryboardSegue) {
    //        //save new car info
    //
    //        if segue.sourceViewController .isKindOfClass(NewCarViewController) {
    //            print( "Oh no!" )
    //        }
    //
    //
    //        //self.performSegueWithIdentifier("goBackToMenu", sender: self)
    //        print("Hello!")
    //    }
    //
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        //put stuff to save textfield's text
    }
    
    
}
