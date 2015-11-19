//
//  MenuTableViewController.swift
//  CarFile
//
//  Created by Travis Siems on 10/26/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import UIKit
import CoreData

class MenuTableViewController: UITableViewController {
    
    var titleText: String?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.leftBarButtonItem = editButtonItem()
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

        
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        var fetchRequest = NSFetchRequest(entityName: "Car")
        
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            cars = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        //2
        fetchRequest = NSFetchRequest(entityName: "MaintenanceItem")
        
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            maintenanceItems = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        populateTestData()
        
        tableView.reloadData()
    }
    
    override func viewDidAppear(animate: Bool) {
        tableView.reloadData()
    }
    
    func populateTestData() {
//        if carMgr.cars.count < 1 {
//            for car in cars
//            {
//                let id = car.valueForKey("id") as! Int
//                let name = car.valueForKey("name") as! String
//                let make = car.valueForKey("make") as! String
//                let model = car.valueForKey("model") as! String
//                let year = car.valueForKey("year") as! String
//                let color = car.valueForKey("color") as! String
//                let price = car.valueForKey("price") as! String
//                let licNum = car.valueForKey("licNum") as! String
//                let vinNum = car.valueForKey("vinNum") as! String
//                let notes = car.valueForKey("notes") as! String
//                
//                carMgr.addCar(id, name: name, make:make, model:model, year:year, color:color, price:price, vinNum:vinNum, licNum:licNum, notes:notes)
//            }
            
//            for item in maintenanceItems
//            {
//                let carID = item.valueForKey("carID") as! Int
//                let type = item.valueForKey("type") as! String
//                let last = item.valueForKey("lastDate") as! String
//                let next = item.valueForKey("nextDate") as! String
//                let brand = item.valueForKey("brand") as! String
//                let locPurchased = item.valueForKey("locPurchased") as! String
//                let price = item.valueForKey("price") as! String
//                let notes = item.valueForKey("notes") as! String
//                
//                carMgr.addMaintenanceItem(carID, type: type, last: last, next: next, description: brand, price: price, locPurchased: locPurchased, notes: notes)
//            }
//        }
//        if carMgr.cars.count < 1 {
//            carMgr.addCar(0,name: "Steven's Car",make: "Ford", model: "Focus", year: "2015", color: "Blue", price: "$5,000", licNum: "5CIA356")
//            carMgr.addCar(1,name: "Nick's Car",make: "Mini", model: "Countryman", year: "2012", color: "White", price: "$6,000", licNum: "4KGB578")
//            carMgr.addCar(2,name: "Travis's Car",make: "Chevrolet", model: "Corvette", year: "2015", color: "Red", price: "$90,000", licNum: "7ULM523")
//        }
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
        return cars.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("carMenuCell", forIndexPath: indexPath) as! MenuTableViewCell
        
        // Configure the cell...
        cell.nameLabel.text = cars[indexPath.row].valueForKey("name") as? String
        cell.makeLabel.text = cars[indexPath.row].valueForKey("make") as? String
        cell.modelLabel.text = cars[indexPath.row].valueForKey("model") as? String
        cell.yearLabel.text = cars[indexPath.row].valueForKey("year") as? String
        cell.colorLabel.text = cars[indexPath.row].valueForKey("color") as? String
        cell.priceLabel.text = cars[indexPath.row].valueForKey("price") as? String
        cell.licNumLabel.text = cars[indexPath.row].valueForKey("licNum") as? String
        
        
        // set color of cell
        let styleID = cars[indexPath.row].valueForKey("styleID") as? String
        
        print(styleID)
        

        
        return cell
    }
        
    
    @IBAction func cancelToMenu(segue:UIStoryboardSegue) {
        print("Cancel to menu")
        
    }
    
    @IBAction func saveToMenu(segue:UIStoryboardSegue) {
        //save new car info
        
        if segue.sourceViewController .isKindOfClass(NewCarViewController) {
            let source = segue.sourceViewController as! NewCarViewController
            if source.nameTextField.text!.characters.count > 0 {
                saveCar(source.nameTextField.text!, make:source.makeTextField.text!, model:source.modelTextField.text!, year:source.yearTextField.text!, color:source.colorTextField.text!, price:source.priceTextField.text!, vinNum:source.vinNumTextField.text!, licNum:source.licNumTextField.text!, notes:source.notesTextField.text!, styleID: source.styleID!)
            }
        }
        
    }
    
    
    func saveCar(name: String, make:String, model:String, year:String, color:String, price:String, vinNum:String, licNum:String, notes:String,styleID:String="") {

        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        

        let entity =  NSEntityDescription.entityForName("Car",
            inManagedObjectContext:managedContext)
        
        let vehicle = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        var carID = 0
        
        for car in cars
        {
            let thisCarID = car.valueForKey("id") as? Int
            
            if car.valueForKey("id") as? Int > carID
            {
                carID = thisCarID!
            }
        }
        
        carID++
        

        let values: [String: AnyObject] = ["id":carID, "name":name,"make":make,"model":model, "year":year, "color":color,"price":price, "vinNum":vinNum, "licNum":licNum, "notes":notes, "styleID":styleID]
        vehicle.setValuesForKeysWithDictionary(values)
        

        do {
            try managedContext.save()
            
            cars.append(vehicle)
            
            //carMgr.addCar(carID, name: name, make:make, model:model, year:year, color:color, price:price, vinNum:vinNum, licNum:licNum, notes:notes)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
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
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //delete a car
        if editingStyle == .Delete
        {
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            let thisCarID = cars[indexPath.row].valueForKey("id") as? Int
            
            
            
            for i in 0...maintenanceItems.count-1
            {
                if maintenanceItems[i].valueForKey("carID") as? Int == thisCarID
                {
                    managedContext.deleteObject(maintenanceItems[i] as NSManagedObject)
                }
            }
            
            //delete the car
            managedContext.deleteObject(cars[indexPath.row] as NSManagedObject)
            cars.removeAtIndex(indexPath.row)
            
            appDelegate.saveContext()
            
            tableView.reloadData()
        }
    }
}
