//
//  ContentView.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//

import SwiftUI
import SwiftData

import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject var tabRouter = TabRouter()

    var body: some View {
        TabView(selection: $tabRouter.selectedTab) {
            TaskMainView()
                .tabItem {
                    Image(systemName: "square.and.arrow.up.on.square.fill")
                    Text("Main")
                }
                .tag(0)

            TaskCreateView()
                .environmentObject(tabRouter)
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("Create")
                }
                .tag(1)
            
            TaskCalendar()
                .environmentObject(tabRouter)
                .tabItem {
                    Image(systemName: "calendar.fill")
                    Text("Calendar")
                }
                .tag(2)

            AdminView()
                .tabItem {
                    Image(systemName: "apple.fill")
                    Text("Admin")
                }
                .tag(3)
        }
        .accentColor(.orange)
    }
}


#Preview {
    ContentView()
}
