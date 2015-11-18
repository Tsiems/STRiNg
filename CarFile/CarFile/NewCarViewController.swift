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

class NewCarViewController: UIViewController {

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
        var vin = ""
        vin = populateVinTextField.text!
        if vin.characters.count == 17
        {
            do {
                let opt = try HTTP.GET("https://api.edmunds.com/api/vehicle/v2/vins/" + vin + "?fmt=json&api_key=5zyd8sa5k3yxgpcg7t49agav")
                opt.start { response in
                    if let err = response.error {
                        print("error: \(err.localizedDescription)")
                        return //also notify app of failure as needed
                    }
                    print("opt finished: \(response.description)")
                    //print("data is: \(response.data)") access the response of the data with response.data
                }
            } catch let error {
                print("got an error creating the request: \(error)")
            }
        }
        else
        {
            print("Error")
            print("VIN LENGTH " , vin.characters.count)
            print(vin)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
