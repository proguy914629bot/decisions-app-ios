//
//  DecisionsApp.swift
//  Decisions
//
//  Created by Mac on 01/07/26.
//

import SwiftUI
import SwiftData

@main
struct DecisionsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DecisionData.self)
    }
}
