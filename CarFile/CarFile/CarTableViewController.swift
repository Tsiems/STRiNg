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
        
        
        
        
        //get title of car
        title = carMgr.cars[carIndex!].name
        
        //set colors of background, title bar, and text
        
        
        populateTestData()
        
        if alertMgr.count == 0 {
            print("setting alerts")
            setAlerts()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func populateTestData() {
        if carMgr.cars[0].maintenanceItems.count < 1 {
            carMgr.addMaintenanceItem(0,type:"Oil Change", last:"5/27/15", next:"8/27/15", description: "Full Synthetic", price: "$50", locPurchased: "Speedee Oil Change", notes: "It was pretty expensive but fast")
            carMgr.addMaintenanceItem(0,type:"Battery", last:"5/27/11", next:"12/10/21")
            carMgr.addMaintenanceItem(0,type:"Tires", last:"12/04/00", next:"12/04/19")
            carMgr.addMaintenanceItem(0,type:"Transmission Fluid", last: "2/10/14", next:"11/21/15")
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
        return carMgr.cars[carIndex!].maintenanceItems.count + 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("alertsCell", forIndexPath: indexPath) as! MaintenanceItemCell
            
            // Configure the cell...
            cell.name.text = "Alerts"
            cell.number.text = String(countAlerts())
            
            //set color of cell
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("testCell", forIndexPath: indexPath) as! MaintenanceItemCell

            // Configure the cell...
            cell.name.text = carMgr.cars[carIndex!].maintenanceItems[indexPath.row-1].type
            
            //set color of cell

            return cell
        }
    }
    
    func setAlerts() {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        
        let today = NSDate()
        
        for( var i = 0; i < carMgr.cars[carIndex!].maintenanceItems.count; i++ )
        {
            let thisDate = dateFormatter.dateFromString(carMgr.cars[carIndex!].maintenanceItems[i].next!)
            
            //check if the date has passed by!
            if today.compare(thisDate!) == NSComparisonResult.OrderedDescending {
                alertMgr.append( alert(carIndex: carIndex, maintenanceItemIndex: i, alertChecked: false) )
                print(carMgr.cars[carIndex!].maintenanceItems[i].type)
            }
        }
    }
    
    
    func countAlerts() -> Int {
        return alertMgr.count
    }
    


    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "itemSegue" {
            // Get the new view controller using segue.destinationViewController.
            let maintenanceInfo = segue.destinationViewController as! CarInfoViewController
            
            //get the row of the selected cell in the table
            let row = tableView.indexPathForCell(sender as! MaintenanceItemCell)!.row
            
            // Pass the selected object to the new view controller.
            maintenanceInfo.carIndex = carIndex
            maintenanceInfo.maintenanceIndex = row - 1
        }
        else if segue.identifier == "alertsSegue" {
            let alertsInfo = segue.destinationViewController as! AlertsTableViewController
            
            alertsInfo.carIndex = carIndex
        }
        
        
    }
    
    
    @IBAction func saveNewData(segue: UIStoryboardSegue) {
        if segue.sourceViewController .isKindOfClass(NewDataViewController) {
            let source = segue.sourceViewController as! NewDataViewController
            if source.typeTextField.text!.characters.count > 0 {
                
                carMgr.addMaintenanceItem(carIndex!, type: source.typeTextField.text!, last: source.lastDateButton.titleLabel!.text!, next: source.nextDateButton.titleLabel!.text!, description: source.descriptionTextField.text!, price: source.priceTextField.text!, locPurchased: source.whereTextField.text!, notes: source.notesTextField.text!)
            }
        }
    }
    
    @IBAction func cancelNewData(segue: UIStoryboardSegue) {
        print( "cancel new data" )
    }


}
