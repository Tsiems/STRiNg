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
            titleText = "Car Menu"
        }
        
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        title = titleText
        //tableView.registerClass(CarTableViewCell.self, forCellReuseIdentifier: "testCell")
        populateTestData()
        
    }
    
    func populateTestData() {
        if carMgr.cars.count < 1 {
            carMgr.addCar(1,name: "Honda Accord",description: "Sweet ride. 1998. Will break down.")
            carMgr.addCar(2,name: "Kia Soul",description: "White. Fun. Good gas milage. Hampsters.")
            carMgr.addCar(3,name: "Jeep",description: "I don't know jeep stuff.")
        }
        
        //        carNames.append("First")
        //        carNames.append("Second")
        //        carNames.append("Third")
        //        carNames.append("Fourth")
        //        carNames.append("Fifth")
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
        let cell = tableView.dequeueReusableCellWithIdentifier("testCell", forIndexPath: indexPath) as! CarTableViewCell
        
        // Configure the cell...
        cell.name.text = carMgr.cars[indexPath.row].name
        
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
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "carSegue" {
            // Get the new view controller using segue.destinationViewController.
            let carTable = segue.destinationViewController as! CarTableViewController
            
            
            
            let row = tableView.indexPathForCell(sender as! CarTableViewCell)!.row
            
            // Pass the selected object to the new view controller.
            carTable.carIndex = row
            
            print(carTable.carIndex)
            
        }
        
        
    }
    
}
