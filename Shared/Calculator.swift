//
//  Calculator.swift
//  CalculatorHW
//
//  Created by Haley Womack on 8/22/22.
//

import Foundation

class Calculator: ObservableObject {
    
    //Used to update the UI
    //Published will mean it updates as the app is running
    @Published var displayValue = "0"
    
    //store the current operator
    var currentOp: Operator?
    
    //current number selected
    var currentNumber: Double? = 0
    
    //prevoius number selected, original value set to nil
    var previousNumber: Double? = nil
    
    //Flag for equal pressed
    var equaled = false
    
    //How many decimal places have been typed
    var decimalPlace = 0
    
    ///Selects the appropriate function based on the button pressed
    func buttonPressed (label:String) {
        
        if label == "CE" {
            //clear values
            displayValue = "0"
            reset()
            
        } else if label == "=" {
            equalsClicked()
        } else if label == "." {
            decimalClicked()
        } else if let value = Double(label) {
            numberPressed(value: value)
        } else {
            operatorPressed(op: Operator(label))
        }
        
    }
    
    //set display value
    func setDisplayValue (number: Double) {
        
        //don't display a decimal if number is an integer
        //floor function always rounds
        if number == floor(number){
            
            displayValue = "\(Int(number))"
            
        }
        //otherwise display the decimal
        else {
            let decimalPlaces = 10
            displayValue = "\(round(number * pow(10, decimalPlaces) / pow(10, decimalPlaces)))"
            
        }
    }
    
    /// Resets the state of the calculator
    func reset () {
        currentOp = nil
        currentNumber = 0
        previousNumber = nil
        equaled = false
        decimalPlace = 0
    }
    
    //returns true if division by 0 is possible
    func checkForDivision() -> Bool {
        
        if currentOp!.isDivision && (currentNumber == nil && previousNumber == 0) || (currentNumber == 0) {
            displayValue = "Error: cannot divide by zero"
            reset()
            return true
        }
        return false
    }
    
    
    func equalsClicked() {
        
        //check if we have an operation to perform
        if currentOp != nil {
            
            //reset the decimal place
            decimalPlace = 0
            
            //guard for division by 0
            if checkForDivision() {return}
            
            //do we have at least one operand?
            if currentNumber != nil || previousNumber != nil {
                
                //compute the total
                let total = currentOp!.op(previousNumber ?? currentNumber!, currentNumber ?? previousNumber!)
                
                //update first operand
                if currentNumber == nil {
                    currentNumber = previousNumber
                }
                //update second operand
                previousNumber = total
                
                //set equaled flag
                equaled = true
                
                //update UI
                setDisplayValue(number: total)
                
            }
        }
    }
    
    func decimalClicked() {
        
        //guard against funky decimals
        guard decimalPlace == 0 else {return}
        
        //if equals was pressed, reset current numbers
        if equaled {
            
            currentNumber = nil
            previousNumber = nil
            equaled = false
            
        }
        //if decimal was typed first, set the current number
        if currentNumber == nil {
            
            currentNumber = 0
            
        }
        //set the decimal place
        decimalPlace = 1
        
        //update UI
        setDisplayValue(number: currentNumber!)
        displayValue.append(".")
    }
    
    func numberPressed(value: Double) {
        
        // if equals was pressed, clear the current numbers
        if equaled == true {
            currentNumber = nil
            previousNumber = nil
            equaled = false
        }
        
        //if there is no current number, set it to the value
        if currentNumber == nil {
            
            //if decimal place is 0, then value will be divided by 10^0 = 1, which does not change the value
            //if decimal place is 1, then value will be divided by 10^1 = 0.1
            //etc...
            currentNumber = (value / pow(10, decimalPlace))
        
        }
        //if there is an existing current number, add it to the value
        else {
            
            //if no decimal was typed, add the value as the last digit of the number
            if decimalPlace == 0 {
                
                currentNumber = currentNumber! * 10 + value
                
            }
            //if decimal was typed, add the value as the last decimal of the number
            else {
                
                currentNumber = currentNumber! + value / pow(10, decimalPlace)
                decimalPlace += 1
                
            }
            
        }
        
        //Update the UI
        setDisplayValue(number: currentNumber!)
        
    }
    
    func operatorPressed(op:Operator) {
        
        //disable that operator button
        
        
        //reset the decimal, irrelevant at this point
        decimalPlace = 0
        
        //if equals was pressed, reset current number
        if equaled {
            currentNumber = nil
            equaled = false
            
        }
        
        //if we have two operands, compute them, update UI with answer
        if currentNumber != nil && previousNumber != nil {
            
            if checkForDivision() {return}
            
            let total = currentOp!.op(previousNumber!, currentNumber!)
            
            previousNumber = total
            currentNumber = nil
            
            //update UI
            setDisplayValue(number: total)
            
        }
        //if only one number is given, move it to the second operand
        else if previousNumber == nil {
            
            previousNumber = currentNumber
            currentNumber = nil
            
        }
        
        currentOp = op
        
    }
    
}

//pass in integers and return doubles
func pow(_ base: Int, _ exp: Int) -> Double {
    
    return pow(Double(base), Double(exp))
}
