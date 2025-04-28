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
    var body: some View {
        TabView{
            TaskCreateView()
                .tabItem {
                    VStack {
                        Image(systemName: "flame.fill")
                        Text("Home")
                    }
                }
        
            AdminView()
                .tabItem {
                    VStack {
                        Image(systemName: "apple.fill")
                        Text("Home")
                    }
                }
            }
        .accentColor(.orange) // 선택된 탭 색상
        }
    }

#Preview {
    ContentView()
}
