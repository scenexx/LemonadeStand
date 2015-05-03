//
//  WorkDay.swift
//  Lemonade Stand
//
//  Created by Michael Ferdinand on 5/1/15.
//  Copyright (c) 2015 Michael Ferdinand. All rights reserved.
//

import Foundation
import UIKit

struct Report {
    let customers:Int
    let sales:Int
    let revenue:Int
}

class WorkDay {
    class func work (lemonadeMix: Float, weather:String) -> Report {
        let lemonadePrice = 1
        let customers = howManyCustomers(weather)
        var sales = 0
        
        for var x = 0; x < customers; x++ {
            let preference = Float(arc4random_uniform(10) + 1) / 10.0
            if lemonadeMix > 1 && preference < 0.5 {sales++}// customer likes it strong, and the lemonade is strong
            else if lemonadeMix == 1 && preference > 0.4 && preference < 0.7 {sales++}//an even blend pleases this customer
            else if lemonadeMix < 1 && preference > 0.6 {sales++}// customers enjoyed your weaker lemonade
        }
        
        return Report(customers: customers, sales: sales, revenue: sales * lemonadePrice)
    }
    
    class func howManyCustomers(weather: String) -> Int {
        var customers = Int(arc4random_uniform(10)) + 1
        switch weather {
        case "Cold":
            let customers = Int(arc4random_uniform(10)) - 2
        case "Mild":
            let customers = Int(arc4random_uniform(10)) + 1
        case "Warm":
            let customers = Int(arc4random_uniform(10)) + 5
        default:
            return -1       //error value
        }
        if customers < 0 {customers = 0}
        return customers
    }
    
    class func weather() -> String {
        let d3roll = Int(arc4random_uniform(3)) + 1 // varies from 1 to 3
        switch d3roll {
        case 1: return "Cold"
        case 2: return "Mild"
        case 3: return "Warm"
        default: return "Error"
        }
    }
}