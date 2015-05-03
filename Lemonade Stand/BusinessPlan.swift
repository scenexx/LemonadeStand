//
//  BusinessPlan.swift
//  Lemonade Stand
//
//  Created by Michael Ferdinand on 5/1/15.
//  Copyright (c) 2015 Michael Ferdinand. All rights reserved.
//

import Foundation


class BusinessPlan {    //manage the store. Oversees Inventory and Lemonade
    
    //self-explanatory variables
    var theInventory = Inventory()
    var recipe = Lemonade()
    
    func newPlan() {              //restore default values
        theInventory = Inventory()
        recipe = Lemonade()
    }
    
    //add and remove items from inventory
    //functions return the inventory to update the UI
    func addLemonsToInventory(howMany: Int) -> Inventory {
        theInventory.addLemons(howMany)
        return theInventory
    }
    func addIceToInventory(howMany: Int) -> Inventory {
        theInventory.addIce(howMany)
        return theInventory
    }
    func removeLemonsFromInventory(howMany: Int) -> Inventory {
        theInventory.removeLemons(howMany)
        return theInventory
    }
    func removeIceFromInventory(howMany: Int) -> Inventory {
        theInventory.removeIce(howMany)
        return theInventory
    }
    func inventory() -> Inventory {
        return theInventory
    }
    
    //here's where the recipe is determined.
    //Lemonade's lemon, ice, and error variables are managed manually
    func addLemonsToMix(howMany: Int) -> Lemonade {
        if (howMany + recipe.lemons) > theInventory.lemons {
            recipe.error = "Not enough lemons in stock"
        } else {
            recipe.lemons += howMany
        }
        return recipe
    }
    func addIceToMix(howMany: Int) -> Lemonade {
        if (howMany + recipe.ice) > theInventory.ice {
            recipe.error = "Not enough ice in stock"
        } else {
            recipe.ice += howMany
        }
        return recipe
    }
    func removeLemonsFromMix(howMany: Int) -> Lemonade {
        if howMany >= recipe.lemons {
            recipe.error = "Would you like some lemons in your lemonade?"
        } else {
            recipe.lemons -= howMany
        }
        return recipe
    }
    func removeIceFromMix(howMany: Int) -> Lemonade {
        if howMany > recipe.ice {       //I guess you can have lemonade without ice...
            recipe.error = "You just ran out of ice to give."
        } else {
            recipe.ice -= howMany
        }
        return recipe
    }
    func getMix() -> Float {
        return recipe.mix
    }
    
    //After the customers come through we have some tidying up to do
    func closeForTheNight(theRevenue: Int) -> Inventory {
        //here we update the books
        theInventory.updateBooks(recipe.lemons, iceUsed: recipe.ice, revenue: theRevenue)
        //a new day calls for a new recipe
        recipe = Lemonade()
        
        //return theInventory for UI update
        return theInventory
    }
    
    func clearErrors() {      //called after an error UIAlert dialog
        theInventory.error = ""
        recipe.error = ""
    }
}