//
//  bombApp.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//

import SwiftUI
import SwiftData

class TabRouter: ObservableObject {
    @Published var selectedTab: Int = 0
    @Published var isCompleted: Int = 0
}

@main
struct bombApp: App {
    
    @StateObject var tabRouter = TabRouter()
    
    var body: some Scene {
        WindowGroup {
            Intro0View()
        }
        .modelContainer(for: [CategoryModel.self, ItemModel.self, TaskModel.self, BombModel.self])

    }
}
