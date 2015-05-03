//
//  Inventory.swift
//  Lemonade Stand
//
//  Created by Michael Ferdinand on 5/1/15.
//  Copyright (c) 2015 Michael Ferdinand. All rights reserved.
//

import Foundation

class Inventory {       //Procures and tracks inventory
    let kLemonCost = 2
    let kIceCost = 1
    
    var lemons = 1
    var ice = 1
    var cash = 10
    var error = ""  //a string to display when something goes wrong
    
    func addLemons(howMany: Int) {
        if (howMany * kLemonCost) > cash {
            error = "SHOW ME THE MONEY!!!"
        } else {
            lemons += howMany
            cash -= (howMany * kLemonCost)
        }
    }
    
    func removeLemons(howMany: Int) {
        if howMany >= lemons {
            error = "You can't make lemonade without breaking a few lemons"
        } else {
            lemons -= howMany
            cash += (howMany * kLemonCost)
        }
    }
    
    func addIce(howMany: Int) {
        if (howMany * kIceCost) > cash {
            error = "Not enough cold, hard cash"
        } else {
            ice += howMany
            cash -= (howMany * kIceCost)
        }
    }
    
    func removeIce(howMany: Int) {
        if howMany > ice {
            error = "But why is the ice gone?"
        } else {
            ice -= howMany
            cash += (howMany * kIceCost)
        }
    }
    
    func updateBooks (lemonsUsed: Int, iceUsed: Int, revenue: Int) {
        lemons -= lemonsUsed
        ice -= iceUsed
        cash += revenue
        
        if (cash + (ice * kIceCost)) < kLemonCost && lemons == 0{
            error = "Game Over\nTry Again"
        }
    }
}