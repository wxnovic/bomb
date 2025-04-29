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
                    Image(systemName: "flame.fill")
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
                    Image(systemName: "flame.fill")
                    Text("Calendar")
                }
                .tag(2)

            TaskGView()
                .environmentObject(tabRouter)
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("GView")
                }
                .tag(3)
            AdminView()
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("Admin")
                }
                .tag(4)
        }
        .accentColor(.orange)
    }
}


#Preview {
    ContentView()
}
