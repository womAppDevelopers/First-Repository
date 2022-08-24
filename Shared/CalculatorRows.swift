//
//  CalculatorRows.swift
//  CalculatorHW
//
//  Created by Haley Womack on 8/22/22.
//

import SwiftUI

let columnCount = 4

struct CalculatorRows: View {
    
    var rowLabel = ["","","",""]
    var rowColor: [Color] = [.gray, .gray, .gray, .green]
    
    var body: some View {
        //display a calculator button for each column
        HStack(spacing:10){
            ForEach (0..<columnCount) {
                index in CalculatorButton(label: rowLabel[index], color: rowColor[index])
            }
        }
    }
}

struct CalculatorRows_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorRows(rowLabel: ["1", "2", "3", "+"])
            .previewLayout(.fixed(width: 300, height: 100))
    }
}
