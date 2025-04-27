//
//  TaskCreateStep4View.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//

import SwiftUI

struct TaskCreateStep4View: View {
    @State private var showButtons: [Bool] = Array(repeating: false, count: 7)
    @State private var isExpanded: Bool = false
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "M/d" // "5/1" 이런 스타일
        return f
    }()
    
    var body: some View {
        let buttonCount = 7
        let distance: CGFloat = 120
        
        ZStack {
            // 중앙 버튼
            Button(action: {
                isExpanded.toggle()
                
                if isExpanded {
                    // 버튼 순차적으로 등장
                    for i in 0..<buttonCount {
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.05) {
                            withAnimation(.spring()) {
                                showButtons[i] = true
                            }
                        }
                    }
                } else {
                    // 버튼 순차적으로 사라짐
                    for i in 0..<buttonCount {
                        DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.05) {
                            withAnimation(.spring()) {
                                showButtons[i] = false
                            }
                        }
                    }
                }
                
            }) {
                Text("자료준비")
                    .padding()
                    .frame(width: 100, height: 50)
                    .foregroundColor(.black)
                    .font(.system(size: 15, weight: .bold, design: .default))
            }
            .background(Color(hex: "151515").opacity(0.1).blur(radius: 2))
            .cornerRadius(20)
            
            // 주변 버튼들
            ForEach(0..<buttonCount, id: \.self) { index in
                let angle = Double(index) * (360.0 / Double(buttonCount))
                let date = Calendar.current.date(byAdding: .day, value: index, to: Date()) ?? Date()
                
                Button(action: {}) {
                    Text(formatter.string(from: date))
                        .padding()
                        .frame(width: 70, height: 100)
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .bold, design: .default))
                }
                .background(Color(hex: "151515").opacity(0.1).blur(radius: 2))
                .cornerRadius(20)
                .offset(y: showButtons[index] ? -distance : 0) // 나타날 때 y 이동
                .rotationEffect(.degrees(angle))
                .opacity(showButtons[index] ? 1 : 0) // 사라질 때 투명도
                .animation(.spring(), value: showButtons[index])
            }
        }
    }
}
