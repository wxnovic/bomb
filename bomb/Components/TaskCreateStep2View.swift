//
//  TaskCreateStep2View.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//

import SwiftUI

struct TaskCreateStep2View: View {
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "M/d" // "5/1" 이런 스타일
        return f
    }()
    
    var body: some View {
        VStack {
            Text("언제까지?")
                .font(.system(size: 30, weight: .bold, design: .default))
                .shadow(radius: 5)
                .padding()
            
            ScrollView {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.fixed(70), spacing: 20), count: 4),
                    alignment: .center,
                    spacing: 20
                ) {
                    ForEach(0..<7) { i in
                        let date = Calendar.current.date(byAdding: .day, value: i, to: Date()) ?? Date()

                        Button(action: {}) {
                            Text(formatter.string(from: date))
                                .padding()
                                .frame(width: 70, height: 50)
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .bold, design: .default))
                        }
                        .background(Color.init(hex: "151515").opacity(0.1).blur(radius: 2))
                        .cornerRadius(20)
                    }
                }
            }
        }
    }
}
