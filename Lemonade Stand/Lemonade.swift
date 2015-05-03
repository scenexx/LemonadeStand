//
//  Lemonade.swift
//  Lemonade Stand
//
//  Created by Michael Ferdinand on 5/1/15.
//  Copyright (c) 2015 Michael Ferdinand. All rights reserved.
//

import Foundation

class Lemonade {
    
    //changing lemons or ice will cause calculateStrength() to be called
    var lemons = 0 {didSet{calculateStrength()}
    }
    var ice = 0{ didSet{calculateStrength()}
    }
    
    var mix:Float = 0.0
    var strength = "None"
    var error = ""
    
    func calculateStrength() {
        if ice > 0 && lemons > 0 {  //we can't divide by zero, and what's lemonade without lemons?
            mix = Float(lemons) / Float (ice)
            if ice == lemons {strength = "Blended"}
            if ice > lemons {strength = "Diluted"}
            if ice < lemons {strength = "Strong"}
        } else {
            if ice == 0 {strength = "Strong"; mix = -1} //it's all lemon
            else if lemons == 0 {strength = "None"; mix = -10}//it's water
            else {error = "Negative lemons or ice? Inconcievable!"}
        }
    }
}