//
//  TaskCreateStep3.View.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//
import SwiftUI

struct TaskCreateStep3View: View {
    // Test Data
    let tasks: [String] = [
        "자료조사", "개요작성", "디자인", "최종화"
    ]
    
    var body: some View {
        VStack {
            Text("어떻게 해볼까?")
                .font(.system(size: 30, weight: .bold, design: .default))
                .shadow(radius: 5)
                .padding()
            
            ScrollView {
                LazyVGrid(
                    columns: Array(repeating: GridItem(.fixed(100), spacing: 20), count: 3),
                    alignment: .center,
                    spacing: 20
                ) {
                    

                    ForEach(tasks, id: \.self){ task in
                        Button(action: {}) {
                            Text(task)
                                .padding()
                                .frame(width: 100, height: 50)
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .bold, design: .default))
                        }
                        .background(Color.init(hex: "151515").opacity(0.1).blur(radius: 2))
                        .cornerRadius(20)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .padding()
                            .frame(width: 100, height: 50)
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
