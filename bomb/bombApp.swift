//
//  bombApp.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//

import SwiftUI
import SwiftData

@main
struct bombApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [CategoryModel.self, ItemModel.self, TaskModel.self, BombModel.self])

    }
}
