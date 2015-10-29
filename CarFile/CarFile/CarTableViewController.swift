//
//  CarTableViewController.swift
//  CarFile
//
//  Created by Travis Siems on 10/15/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit

class CarTableViewController: UITableViewController {
    
    
    var carIndex: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
//        let backItem = UIBarButtonItem(title: "Custom Text HERE", style: .Bordered, target: nil, action: nil)
//        navigationItem.backBarButtonItem = backItem
        
        
        
        
        
        //get title of car
        title = carMgr.cars[carIndex!].name
        
        //set colors of background, title bar, and text
        
        //tableView.registerClass(CarTableViewCell.self, forCellReuseIdentifier: "testCell")
        populateTestData()
        
    }
    
    func populateTestData() {
        if carMgr.cars[0].maintenanceItems.count < 1 {
            carMgr.addMaintenanceItem(0,name:"Oil Change", last:"05-27-15", next:"08-27-15")
            carMgr.addMaintenanceItem(0,name:"Batteries", last:"05-27-11")
            carMgr.addMaintenanceItem(0,name:"Tires", last:"12-04-00")
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
        return carMgr.cars[carIndex!].maintenanceItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("testCell", forIndexPath: indexPath) as! MaintenanceItemCell

        // Configure the cell...
        cell.name.text = carMgr.cars[carIndex!].maintenanceItems[indexPath.row].name
        
        //set color of cell

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
//        let currentCell = tableView.cellForRowAtIndexPath(indexPath) as! MaintenanceItemCell
//        
//        selectedMaintenanceItem = indexPath.row
//        
//        print(selectedMaintenanceItem)
//        
//        print(currentCell.name!.text)
//    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "itemSegue" {
            // Get the new view controller using segue.destinationViewController.
            let maintenanceInfo = segue.destinationViewController as! CarInfoViewController
            
            //get the row of the selected cell in the table
            let row = tableView.indexPathForCell(sender as! MaintenanceItemCell)!.row
            
            // Pass the selected object to the new view controller.
            maintenanceInfo.carIndex = carIndex
            maintenanceInfo.maintenanceIndex = row
        }
        
        
    }


}
