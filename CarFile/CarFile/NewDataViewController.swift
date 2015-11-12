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
    @IBOutlet weak var lastTextField: UITextField!
    @IBOutlet weak var nextTextField: UITextField!
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
