//
//  AlertsTableViewController.swift
//  CarFile
//
//  Created by Travis Siems on 11/15/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit

class AlertsTableViewController: UITableViewController {

    var carIndex : Int?
    var items = [maintenanceItem]()
    
    let today = NSDate()
    
    let dateFormatter = NSDateFormatter()

    var warningDate : NSDate?

    
    override func viewDidLoad() {
        
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        
        
        
        //set next date to 6 months in the future
        let components: NSDateComponents = NSDateComponents()
        components.setValue(7, forComponent: NSCalendarUnit.Day)
        
        warningDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: today, options: NSCalendarOptions(rawValue: 0))!

        makeInitialItemsList()
        
        super.viewDidLoad()
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeInitialItemsList() {
        //empty the array
        items = []
        
        for( var i = 0; i < carMgr.cars[carIndex!].maintenanceItems.count; i++ ) {
            let item = carMgr.cars[carIndex!].maintenanceItems[i]
            items.append( maintenanceItem(type:item.type!, last:item.last!, next:item.next!, description: item.description!, price:item.price!,locPurchased:item.locPurchased!,notes:item.notes!) )
        }
        sortItems()
    }
    
    func sortItems() {
        print("Sorting alerts")
        items = items.sort({ $0.next!.compare($1.next!) == NSComparisonResult.OrderedAscending })
    }
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("alertCell", forIndexPath: indexPath) as! AlertTableViewCell

        // Configure the cell...
        cell.nameLabel.text = items[indexPath.row].type
        cell.nextLabel.text = items[indexPath.row].next
        

        
        
        let thisDate = dateFormatter.dateFromString(items[indexPath.row].next!)
            
        //check if the date has passed by!
        if today.compare(thisDate!) == NSComparisonResult.OrderedDescending {
            //set the cell color to red
            cell.backgroundColor = UIColor(red:0.91, green:0.34, blue:0.32, alpha:1)
        }
        else if warningDate!.compare(thisDate!) == NSComparisonResult.OrderedDescending {
            //set the cell color to yellow
            cell.backgroundColor = UIColor(red:1, green:0.83, blue:0.35, alpha:1)
        }
        else {
            //set cell color to green
            cell.backgroundColor = UIColor(red:0.54, green:0.76, blue:0.56, alpha:1)
        }
        

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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "itemOnAlertsSegue" {
            // Get the new view controller using segue.destinationViewController.
            let maintenanceInfo = segue.destinationViewController as! CarInfoViewController
            
            //get the row of the selected cell in the table
            let row = tableView.indexPathForCell(sender as! AlertTableViewCell)!.row
            
            // Pass the selected object to the new view controller.
            maintenanceInfo.carIndex = carIndex
            
            
            //get the index in maintenanceItems
            var index = 0
            
            for i in 0...carMgr.cars[carIndex!].maintenanceItems.count-1 {
                if carMgr.cars[carIndex!].maintenanceItems[i] == items[row] {
                    index = i
                }
            }
            
            maintenanceInfo.maintenanceIndex = index
        }
        
        
    }

}
