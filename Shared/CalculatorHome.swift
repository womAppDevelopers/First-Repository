//
//  ContentView.swift
//  Shared
//
//  Created by Haley Womack on 8/16/22.
//

import SwiftUI

var darkerGray = Color(CGColor(gray: 0.1, alpha: 1))
var darkGray = Color(CGColor(gray: 0.3, alpha: 1))

struct CalculatorHome: View {
    
    @EnvironmentObject var calculator: Calculator
    
    var body: some View {
        GeometryReader { geometry in
            
            VStack(alignment: .trailing, spacing: 0) {
                
                Spacer()
                
                //Display current value
                //hook up to model
                Text(calculator.displayValue)
                    .foregroundColor(.white)
                    .font(.system(size: 40))
                    .lineLimit(1)
                    .padding(.leading, 20)
                    .padding(.trailing,30)
                
                //Display rows of calculator buttons
                VStack(spacing: 10) {
                    CalculatorRows(rowLabel: ["CE", "", "", String("\u{00f7}")], rowColor: [darkGray, darkGray, darkGray, .green])
                    CalculatorRows(rowLabel: ["7", "8", "9", String("\u{00d7}")])
                    CalculatorRows(rowLabel: ["4", "5", "6", "-"])
                    CalculatorRows(rowLabel: ["1", "2", "3", "+"])
                    CalculatorRows(rowLabel: ["0", ".", "", "="])

                }
                .frame(height: geometry.size.height * 0.7)
                .padding()
                
            }

        }
        .background(darkerGray)
        .edgesIgnoringSafeArea(.all)

    }
       
}

struct CalculatorHome_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorHome()
            .environmentObject(Calculator())
    }
}
