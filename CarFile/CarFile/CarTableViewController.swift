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
    
    var items = [maintenanceItem]()
    
    let NUM_STATIC_CELLS = 2

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        //get title of car
        title = cars[carIndex!].valueForKey("name") as? String
        
        thisCarID = cars[carIndex!].valueForKey("id") as? Int
        
        //set colors of background, title bar, and text
        
        
        populateTestData()
        
//        if alertMgr.count == 0 {
//            print("setting alerts")
//            setAlerts()
//        }
        

        
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
        tableView.reloadData()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    func populateTestData() {
//        if carMgr.cars[0].maintenanceItems.count < 1 {
//            carMgr.addMaintenanceItem(0,type:"Oil Change", last:"05/27/15", next:"08/27/15", description: "Full Synthetic", price: "$50", locPurchased: "Speedee Oil Change", notes: "It was pretty expensive but fast")
//            carMgr.addMaintenanceItem(0,type:"Battery", last:"05/27/11", next:"12/10/21")
//            carMgr.addMaintenanceItem(0,type:"Tires", last:"12/04/00", next:"12/04/19")
//            carMgr.addMaintenanceItem(0,type:"Transmission Fluid", last: "02/10/14", next:"11/21/15")
//        }
        
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

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("basicInfoCell", forIndexPath: indexPath) as! BasicInfoTableViewCell
            
            // Configure the cell...
            cell.nameLabel.text = cars[carIndex!].valueForKey("name") as? String
            cell.makeLabel.text = cars[carIndex!].valueForKey("make") as? String
            cell.modelLabel.text = cars[carIndex!].valueForKey("model") as? String
            cell.yearLabel.text = cars[carIndex!].valueForKey("year") as? String
            cell.colorLabel.text = cars[carIndex!].valueForKey("color") as? String
            cell.priceLabel.text = cars[carIndex!].valueForKey("price") as? String
            cell.licNumLabel.text = cars[carIndex!].valueForKey("licNum") as? String
            
            //set color of cell
            
            return cell
        }
        if indexPath.row == 1 {
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
    
    
    func countAlerts() -> Int {
        let dateFormatter = NSDateFormatter()
//        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .NoStyle
        dateFormatter.dateFormat = "MM/dd/yy"
        
        let today = NSDate()
        
        var num = 0
        
        for( var i = 0; i < items.count; i++ )
        {
            let thisDate = dateFormatter.dateFromString(items[i].next!)
            
            //check if the date has passed by!
            if today.compare(thisDate!) == NSComparisonResult.OrderedDescending {
                num += 1
            }
        }
        
        return num
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
