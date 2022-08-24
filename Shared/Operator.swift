//
//  Operator.swift
//  CalculatorHW
//
//  Created by Haley Womack on 8/22/22.
//

import Foundation

class Operator {
    
    //stores the value of a method
    var op: (Double, Double) -> Double
    var isDivision = false
    
    init (_ string: String) {
        
        //putting the operator in parentheses stores the result of that operation baed on the two Doubles that are input when the mehtod op is run
        if string == "+" {
            self.op = (+)
            self.isDivision = false
            
        }
        else if string == "-" {
            self.op = (-)
            self.isDivision = false
            
        }
        else if string == String("\u{00f7}") {
            self.op = (*)
            self.isDivision = false
            
        }
        else {
            self.op = (/)
            self.isDivision = true
            
        }
    }    
}
