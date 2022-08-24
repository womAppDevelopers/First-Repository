//
//  CalculatorHWApp.swift
//  Shared
//
//  Created by Haley Womack on 8/16/22.
//

import SwiftUI

@main
struct CalculatorHWApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorHome()
                .environmentObject(Calculator())
        }
    }
}
