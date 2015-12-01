//
//  CarTableViewController.swift
//  CarFile
//
//  Created by Travis Siems on 10/15/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit
import CoreData

class CarTableViewController: UITableViewController {
    
    
    var carIndex: Int?
    var thisCarID: Int?
    var yellowAlerts: Int?
    var redAlerts: Int?
    
    var items = [maintenanceItem]()
    
    let NUM_STATIC_CELLS = 2

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //get title of car
        title = cars[carIndex!].valueForKey("name") as? String
        
        thisCarID = cars[carIndex!].valueForKey("id") as? Int

    }
    
    func addMaintenanceItems()
    {
        items = []
        for item in maintenanceItems
        {
            let itemCarID = item.valueForKey("carID") as? Int
            if itemCarID == thisCarID
            {
                items.append( maintenanceItem(type:item.valueForKey("type") as! String, last:item.valueForKey("lastDate") as! String, next:item.valueForKey("nextDate") as! String, description: item.valueForKey("brand") as! String, price:item.valueForKey("price") as! String,locPurchased:item.valueForKey("locPurchased") as! String,notes:item.valueForKey("notes") as! String) )
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        addMaintenanceItems()
        
        var values = countAlerts()
        yellowAlerts = values.0
        redAlerts = values.1
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + NUM_STATIC_CELLS
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150.0
        }
        else if indexPath.row == 1 { //alert info
            return 40
        }
        else {
            return 65
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("profileCell", forIndexPath: indexPath) as! CarProfileTableViewCell
            
            // Configure the cell...
            cell.makeLabel.text = cars[carIndex!].valueForKey("make") as? String
            cell.modelLabel.text = cars[carIndex!].valueForKey("model") as? String
            cell.yearLabel.text = cars[carIndex!].valueForKey("year") as? String
            
            //set color of cell
            
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("alertsCell", forIndexPath: indexPath) as! MaintenanceItemCell
            
            // Configure the cell...
            cell.name.text = "Alerts"
            
            cell.number.text = String(redAlerts! + yellowAlerts!)
            
            //set color of cell
            if redAlerts == 0 {
                if yellowAlerts == 0 {
                    //set cell color to green
                    cell.backgroundColor = UIColor(red:0.54, green:0.76, blue:0.56, alpha:1)
                }
                else {
                    //set the cell color to yellow
                    cell.backgroundColor = UIColor(red:1, green:0.83, blue:0.35, alpha:1)
                }
            }

            else {
                //set the cell color to red
                cell.backgroundColor = UIColor(red:0.91, green:0.34, blue:0.32, alpha:1)
            }
            
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("maintenanceCell", forIndexPath: indexPath) as! MaintenanceItemCell

            // Configure the cell...
            cell.name.text = items[indexPath.row-NUM_STATIC_CELLS].type
            
            //set color of cell

            return cell
        }
    }
    
//    func setAlerts() {
//        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateStyle = .ShortStyle
//        dateFormatter.timeStyle = .NoStyle
//        
//        let today = NSDate()
//        
//        for( var i = 0; i < carMgr.cars[carIndex!].maintenanceItems.count; i++ )
//        {
//            let thisDate = dateFormatter.dateFromString(carMgr.cars[carIndex!].maintenanceItems[i].next!)
//            
//            //check if the date has passed by!
//            if today.compare(thisDate!) == NSComparisonResult.OrderedDescending {
//                //alertMgr.append( alert(carIndex: carIndex, maintenanceItemIndex: i, alertChecked: false) )
//                print(carMgr.cars[carIndex!].maintenanceItems[i].type)
//            }
//        }
//    }
    
    
    func countAlerts() -> (Int,Int) {
        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateFormat = "MM/dd/yy"
        
        let today = NSDate()
        
        //check 7 days in the future
        let components: NSDateComponents = NSDateComponents()
        components.setValue(7, forComponent: NSCalendarUnit.Day)
        
        let warningDate = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: today, options: NSCalendarOptions(rawValue: 0))!
        
        var numReds = 0
        var numYellows = 0
        
        for( var i = 0; i < items.count; i++ )
        {
            let thisDate = dateFormatter.dateFromString(items[i].next!)
            
            //check if the date has passed by!
            if today.compare(thisDate!) == NSComparisonResult.OrderedDescending {
                numReds += 1
            }
            else if warningDate.compare(thisDate!) == NSComparisonResult.OrderedDescending {
                numYellows += 1
            }
        }
        
        return (numYellows , numReds)
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
            
            var index = 0
            
            for i in 0...maintenanceItems.count-1 {
                if maintenanceItems[i].valueForKey("type") as? String == items[row-NUM_STATIC_CELLS].type {
                    index = i
                }
            }
            
            maintenanceInfo.maintenanceIndex = index
        }
        else if segue.identifier == "alertsSegue" {
            let alertsInfo = segue.destinationViewController as! AlertsTableViewController
            
            alertsInfo.carIndex = carIndex
        }
        else if segue.identifier == "basicInfoSegue" {
            let basicInfoView = segue.destinationViewController as! NewCarViewController

            
            basicInfoView.newCar = false
            basicInfoView.carIndex = carIndex
        }
    }
    
    
    @IBAction func saveNewData(segue: UIStoryboardSegue) {
        if segue.sourceViewController .isKindOfClass(NewDataViewController)
        {
            let source = segue.sourceViewController as! NewDataViewController
            if source.typeTextField.text!.characters.count > 0
            {
                saveMaintenanceItem(source.typeTextField.text!, last: source.lastDateButton.titleLabel!.text!, next: source.nextDateButton.titleLabel!.text!, description: source.descriptionTextField.text!, price: source.priceTextField.text!, locPurchased: source.whereTextField.text!, notes: source.notesTextField.text!)
                
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func cancelNewData(segue: UIStoryboardSegue) {
        print( "cancel new data" )
    }

    
    
    
    // function to interact with CoreData as well as the app data
    func saveMaintenanceItem(type: String, last:String, next:String, description:String, price:String, locPurchased: String, notes: String) {

        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext

        let entity =  NSEntityDescription.entityForName("MaintenanceItem",
            inManagedObjectContext:managedContext)
        
        let maintenanceItem = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        let carID = cars[carIndex!].valueForKey("id") as? Int

        let values: [String: AnyObject] = ["carID":carID!, "type":type,"lastDate":last,"nextDate":next, "brand":description, "price":price, "locPurchased":locPurchased,"notes":notes]
        maintenanceItem.setValuesForKeysWithDictionary(values)
        

        do {
            try managedContext.save()
            
            maintenanceItems.append(maintenanceItem)

            //carMgr.addMaintenanceItem(carID, type: type, last: last, next: next, description: description, price: price, locPurchased: locPurchased, notes: notes)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}
