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
    var thisCarID: Int?
    var items = [maintenanceItem]()
    
    let today = NSDate()
    
    let dateFormatter = NSDateFormatter()

    var warningDate : NSDate?

    
    override func viewDidLoad() {
        
        //dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateFormat = "MM/dd/yy"
        
        thisCarID = cars[carIndex!].valueForKey("id") as? Int
        
        
        //check 7 days in the future
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
        
        
        for item in maintenanceItems
        {
            let itemCarID = item.valueForKey("carID") as? Int
            if itemCarID == thisCarID
            {
                items.append( maintenanceItem(type:item.valueForKey("type") as! String, last:item.valueForKey("lastDate") as! String, next:item.valueForKey("nextDate") as! String, description: item.valueForKey("brand") as! String, price:item.valueForKey("price") as! String,locPurchased:item.valueForKey("locPurchased") as! String,notes:item.valueForKey("notes") as! String) )
            }
        }
        sortItems()
    }
    
    func sortItems() {
        print("Sorting alerts")
        items = items.sort({ dateFormatter.dateFromString($0.next!)!.compare(dateFormatter.dateFromString($1.next!)!) == NSComparisonResult.OrderedAscending })
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
            
            for i in 0...maintenanceItems.count-1 {
                if maintenanceItems[i].valueForKey("type") as? String == items[row].type {
                    index = i
                }
            }
            
            maintenanceInfo.maintenanceIndex = index
        }
    }
}
