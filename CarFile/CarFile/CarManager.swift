//
//  CarObject.swift
//  CarFile
//
//  Created by Travis Siems on 10/18/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import Foundation


var carMgr : CarManager = CarManager()

struct maintenanceItem {
    var name : String?
    
    var last : String?
    var next : String?
    var type : String?
    var price : String?
    var locPurchased : String?
    
    var notes : String?
    
    init(name:String, last:String = "", next:String = "", type:String="", price:String="",locPurchased:String="",notes:String="") {
        self.name = name
        self.last = last
        self.next = next
        self.type = type
        self.price = price
        self.locPurchased = locPurchased
        self.notes = notes
    }
}

struct car {
    var id : Int?
    var name : String?
    var description : String?
    
    var maintenanceItems = [maintenanceItem]()
    
    init(id: Int, name: String, description: String) {
        self.id = id
        self.name = name
        self.description = description
    }
}

class CarManager {
    var cars = [car]()
    
    func addCar(id: Int, name: String, description: String)
    {
        cars.append(car(id:id,name:name,description:description))
    }
    
    func addMaintenanceItem(index: Int, name:String, last:String = "", next:String = "", type:String="", price:String="",locPurchased:String="",notes:String="")
    {
        if index < cars.count {
            cars[index].maintenanceItems.append( maintenanceItem(name:name, last:last, next:next, type:type, price:price,locPurchased:locPurchased,notes:notes) )
        }
    }
    
}











