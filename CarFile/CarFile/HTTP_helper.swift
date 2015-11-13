//
//  HTTP_helper.swift
//  CarFile
//
//  Created by Travis Siems on 11/13/15.
//  Copyright © 2015 STRiNg, int. All rights reserved.
//

import Foundation

import SwiftHTTP


func getGoogle() {
    do {
        let opt = try HTTP.GET("https://api.edmunds.com/api/vehicle/v2/ford/focus%20st?state=new&year=2015&view=basic&fmt=json&api_key=5zyd8sa5k3yxgpcg7t49agav")
        opt.start { response in
            if let err = response.error {
                print("error: \(err.localizedDescription)")
                return //also notify app of failure as needed
            }
            print("opt finished: \(response.description)")
            //print("data is: \(response.data)") access the response of the data with response.data
        }
    } catch let error {
        print("got an error creating the request: \(error)")
    }
}