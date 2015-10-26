//
//  CarObject.swift
//  CarFile
//
//  Created by Travis Siems on 10/18/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import Foundation


var carMgr : CarManager = CarManager()

struct car {
    var id : Int?
    var name : String?
    var description : String?
}

class CarManager {
    var cars = [car]()
    
    func addCar(id: Int, name: String, description: String)
    {
        cars.append(car(id:id,name:name,description:description))
    }
    
}