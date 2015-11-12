//
//  MenuTableViewController.swift
//  CarFile
//
//  Created by Travis Siems on 10/26/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    var carNames = [String]()
    
    var titleText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        if titleText == nil {
            titleText = "Cars"
        }
        
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        title = titleText
        
        //set color of background, title bar, and text
        navigationController!.navigationBar.barTintColor = UIColor(red:0.09,green:0.55,blue:1.00,alpha: 1.00)
        
        let attributes = [
            NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 28)!
        ]
        
        navigationController!.navigationBar.titleTextAttributes = attributes
        
        //self.tableView.backgroundColor = UIColor(red:0.86, green:0.94, blue:0.97, alpha:1)
        
        //configure background of tableView
        //self.tblEvents.backgroundColor = UIColor(red:0.31,green:0.47,blue:0.64,1.00)
        
        //set all navigation buttons to the white color (including back buttons)
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        
        //tableView.registerClass(CarTableViewCell.self, forCellReuseIdentifier: "testCell")
        populateTestData()
        
    }
    
    override func viewDidAppear(animate: Bool) {
        tableView.reloadData()
    }
    
    func populateTestData() {
        if carMgr.cars.count < 1 {
            carMgr.addCar(0,name: "Steven's Car",make: "Ford", model: "Focus", year: "2015", color: "Blue", price: "$5,000", licNum: "5CIA356")
            carMgr.addCar(1,name: "Nick's Car",make: "Mini", model: "Countryman", year: "2013", color: "White", price: "$6,000", licNum: "4KGB578")
            carMgr.addCar(2,name: "Travis's Car",make: "Chevrolet", model: "Corvette", year: "2015", color: "Red", price: "$90,000", licNum: "7ULM523")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return carMgr.cars.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("carMenuCell", forIndexPath: indexPath) as! MenuTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = carMgr.cars[indexPath.row].name
        cell.makeLabel.text = carMgr.cars[indexPath.row].make
        cell.modelLabel.text = carMgr.cars[indexPath.row].model
        cell.yearLabel.text = carMgr.cars[indexPath.row].year
        cell.colorLabel.text = carMgr.cars[indexPath.row].color
        cell.priceLabel.text = carMgr.cars[indexPath.row].price
        cell.licNumLabel.text = carMgr.cars[indexPath.row].licNum
        
        // set color of cell

        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        let indexPath = tableView.indexPathForSelectedRow!
//        
//        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! CarTableViewCell
//        
//        selectedCar = indexPath.row
//        
//        print(selectedCar)
//        
//        print(currentCell.name!.text)
//        
//        performSegueWithIdentifier("carSegue", sender: currentCell)
//    }
    
    
    @IBAction func cancelToMenu(segue:UIStoryboardSegue) {
        print("Hello! Cancel")
        
    }
    
    @IBAction func saveToMenu(segue:UIStoryboardSegue) {
        //save new car info
        
        if segue.sourceViewController .isKindOfClass(NewCarViewController) {
            let source = segue.sourceViewController as! NewCarViewController
            if source.nameTextField.text!.characters.count > 0 {
                carMgr.addCar(3, name: source.nameTextField.text!, make:source.makeTextField.text!, model:source.modelTextField.text!, year:source.yearTextField.text!, color:source.colorTextField.text!, price:source.priceTextField.text!, vinNum:source.vinNumTextField.text!, licNum:source.licNumTextField.text!, notes:source.notesTextField.text!)
            }
        }
        
    }
    

    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "carSegue" {
            // Get the new view controller using segue.destinationViewController.
            let carTable = segue.destinationViewController as! CarTableViewController
            
            let row = tableView.indexPathForCell(sender as! MenuTableViewCell)!.row
            
            // Pass the selected object to the new view controller.
            carTable.carIndex = row
            
            print(carTable.carIndex)
            
        }
    }
}
