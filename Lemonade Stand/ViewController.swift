//
//  ViewController.swift
//  Lemonade Stand
//
//  Created by Michael Ferdinand on 4/29/15.
//  Copyright (c) 2015 Michael Ferdinand. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    //model objects
    let plan = BusinessPlan()
    
    //Inventory display labels
    @IBOutlet weak var inventoryLemonLabel: UILabel!
    @IBOutlet weak var inventoryIceLabel: UILabel!
    @IBOutlet weak var inventoryCashLabel: UILabel!
    
    //Recipe display
    @IBOutlet weak var recipeLemonLabel: UILabel!
    @IBOutlet weak var recipeIceLabel: UILabel!
    @IBOutlet weak var recipeStrengthLabel: UILabel!
    
    //weather UI
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //start everything afresh
        plan.newPlan()
        updateInventoryDisplay(Inventory())
        updateRecipeDisplay(Lemonade())
        updateWeatherDisplay(WorkDay.weather())
    }
    
    //Inventory IBActions
    @IBAction func addLemonToInventory(sender: AnyObject) {
        updateInventoryDisplay(plan.addLemonsToInventory(1))
    }
    @IBAction func removeLemonFromInventory(sender: AnyObject) {
        updateInventoryDisplay(plan.removeLemonsFromInventory(1))
    }
    @IBAction func addIceToInventory(sender: AnyObject) {
        updateInventoryDisplay(plan.addIceToInventory(1))
    }
    @IBAction func removeIceFromInventory(sender: AnyObject) {
        updateInventoryDisplay(plan.removeIceFromInventory(1))
    }
    
    //recipe IBActions
    @IBAction func addLemonToMix(sender: AnyObject) {
        updateRecipeDisplay(plan.addLemonsToMix(1))
    }
    @IBAction func removeLemonFromMix(sender: AnyObject) {
        updateRecipeDisplay(plan.removeLemonsFromMix(1))
    }
    @IBAction func addIceToMix(sender: AnyObject) {
        updateRecipeDisplay(plan.addIceToMix(1))
    }
    @IBAction func removeIceFromMix(sender: AnyObject) {
        updateRecipeDisplay(plan.removeIceFromMix(1))
    }
    
    //Here's where we run the simulation encapsulated in WorkDay
    @IBAction func startWorkDay(sender: AnyObject) {
        if recipeLemonLabel.text != "0" {
            let report = WorkDay.work(plan.getMix(), weather: weatherLabel.text!)
            var reportString = "You had \(report.customers) visit today\n\(report.sales) purchased lemonade\nYou made $\(report.revenue)"
            
            //show the reportString in an action sheet
            let reportDisplay = UIAlertController(title: "Daily Report", message: reportString, preferredStyle: UIAlertControllerStyle.ActionSheet)
            reportDisplay.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(reportDisplay, animated: true, completion: nil)
            
            // balance the books and check for a lack of cash
            //update UI
            updateInventoryDisplay(plan.closeForTheNight(report.revenue))
            updateRecipeDisplay(Lemonade())
            updateWeatherDisplay(WorkDay.weather())
            
        } else {
            displayError("Please mix some lemonade")
        }
    }
    
    //functions to update various displays
    func updateInventoryDisplay (manifest: Inventory) {
        if manifest.error == ""{
            inventoryLemonLabel.text = "\(manifest.lemons)"
            inventoryIceLabel.text = "\(manifest.ice)"
            inventoryCashLabel.text = "$\(manifest.cash)"
        } else {
            displayError(manifest.error)
        }
    }
    func updateRecipeDisplay(recipe:Lemonade) {
        if recipe.error == ""{
            recipeLemonLabel.text = "\(recipe.lemons)"
            recipeIceLabel.text = "\(recipe.ice)"
            recipeStrengthLabel.text = recipe.strength
        } else {
            displayError(recipe.error)
        }
    }
    func updateWeatherDisplay(weather:String) {
        weatherLabel.text = weather
        weatherImage.image = UIImage(named: weather)
    }
    
    func displayError(errorString: String) {
        let alert = UIAlertController(title: "Oops!", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: {()->Void in self.plan.clearErrors()})
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

