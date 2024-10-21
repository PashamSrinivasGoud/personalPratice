//
//  SwiftDataExampleApp.swift
//  SwiftDataExample
//
//  Created by Pasham Srinivas Goud on 17/10/24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Expences.self])
    }
}
