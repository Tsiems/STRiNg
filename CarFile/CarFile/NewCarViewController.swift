//
//  NewCarViewController.swift
//  CarFile
//
//  Created by Travis Siems on 11/1/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit

class NewCarViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var makeTextField: UITextField!
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var colorTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var vinNumTextField: UITextField!
    @IBOutlet weak var licNumTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let backItem = UIBarButtonItem(title: "cancel", style: .Plain, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backItem
        
        title = "New Car"
        
        

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
