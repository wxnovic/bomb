//
//  TaskCreateStep2View.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//

import SwiftUI

struct TaskCreateStep2View: View {
    
    var formData: TaskFormData;
    
    @State private var selectedDayCount: Int? = nil;
    
    let dateFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "M/d" // "5/1"
        return f
    }()
    
    let weekdayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "E" // "Mon", "Tue", "Sun" 이런 식
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
                        let weekday = Calendar.current.component(.weekday, from: date)

                        // 요일에 따른 색깔
                        let weekdayColor: Color = {
                            switch weekday {
                            case 1: // Sunday
                                return .red
                            case 7: // Saturday
                                return .blue
                            default:
                                return .black
                            }
                        }()
                        
                        Button(action: {
                            selectedDayCount = i
                            formData.dayCount = i
                            formData.itemIds.removeAll()
                        }) {
                            VStack(spacing: 2) {
                                Text(dateFormatter.string(from: date)) // 날짜
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(selectedDayCount == i ? Color.white : Color.black)
                                
                                Text(weekdayFormatter.string(from: date)) // 요일
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(selectedDayCount == i ? Color.white : weekdayColor)
                            }
                            .padding()
                            .frame(width: 70, height: 50)
                            .foregroundColor(.black)
                            .background(selectedDayCount == i ?
                                        Color.init(hex: "0938DF").opacity(0.3).blur(radius: 2) :
                                        Color.init(hex: "151515").opacity(0.1).blur(radius: 2))
                        }
                        .background(Color.init(hex: "151515").opacity(0.1).blur(radius: 2))
                        .cornerRadius(20)
                    }
                }
            }
        }.onAppear(){
            if(formData.dayCount != nil) {
                selectedDayCount = formData.dayCount
            }
        }
    }
}
