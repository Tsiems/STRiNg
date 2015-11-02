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
    var type : String?
    
    var last : String?
    var next : String?
    var description : String?
    var price : String?
    var locPurchased : String?
    
    var notes : String?
    
    init(type:String, last:String = "", next:String = "", description:String="", price:String="",locPurchased:String="",notes:String="") {
        self.type = type
        self.last = last
        self.next = next
        self.description = description
        self.price = price
        self.locPurchased = locPurchased
        self.notes = notes
    }
}

struct car {
    var id : Int?
    var name : String?
    var make : String?
    var model : String?
    var year : String?
    var color : String?
    var price : String?
    var vinNum : String?
    var licNum : String?
    var notes : String?
    
    var maintenanceItems = [maintenanceItem]()
    
    init(id: Int, name: String, make: String="",model:String="",year:String="", color:String="", price:String="", vinNum:String="", licNum:String="", notes:String="")
    {
        self.id = id
        self.name = name
        self.make = make
        self.model = model
        self.year = year
        self.color = color
        self.price = price
        self.vinNum = vinNum
        self.licNum = licNum
        self.notes = notes
        
    }
}

class CarManager {
    var cars = [car]()
    
    func addCar(id: Int, name: String, make: String="",model:String="",year:String="", color:String="", price:String="", vinNum:String="", licNum:String="", notes:String="")
    {
        cars.append(car(id:id,name:name,make:make,model:model,year:year,color:color,price:price,vinNum:vinNum,licNum:licNum,notes:notes))
    }
    
    func addMaintenanceItem(index: Int, type:String, last:String = "", next:String = "", description:String="", price:String="",locPurchased:String="",notes:String="")
    {
        if index < cars.count {
            cars[index].maintenanceItems.append( maintenanceItem(type:type, last:last, next:next, description: description, price:price,locPurchased:locPurchased,notes:notes) )
        }
    }
    
}











