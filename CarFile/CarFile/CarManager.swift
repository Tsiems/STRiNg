//
//  CarObject.swift
//  CarFile
//
//  Created by Travis Siems on 10/18/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import Foundation
import CoreData


var carMgr : CarManager = CarManager()

var cars = [NSManagedObject]()
var maintenanceItems = [NSManagedObject]()





struct maintenanceItem : Equatable {
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

//overload equality operator
func ==(lhs: maintenanceItem, rhs: maintenanceItem) -> Bool {
    //make sure every property is the same
    if lhs.type==rhs.type && lhs.last==rhs.last && lhs.next==rhs.next && lhs.description==rhs.description &&
        lhs.price==rhs.price && lhs.locPurchased==rhs.locPurchased && lhs.notes==rhs.notes {
        return true
    }
    return false
}

//overload not equal operator
func !=(lhs:maintenanceItem, rhs: maintenanceItem) -> Bool {
    //call equality function and negate it
    return !(lhs==rhs)
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
    
    func addMaintenanceItem(carID: Int, type:String, last:String = "", next:String = "", description:String="", price:String="",locPurchased:String="",notes:String="")
    {
        if carID < cars.count
        {
            var index = 0
            for var i=0; i < cars.count; i++ {
                if cars[i].id == carID
                {
                    index = i
                    break
                }
            }
            cars[index].maintenanceItems.append( maintenanceItem(type:type, last:last, next:next, description: description, price:price,locPurchased:locPurchased,notes:notes) )
        }
    }
    
}











