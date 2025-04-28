//
//  TaskCreateStep4View.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//

import SwiftUI
import SwiftData

struct TaskCreateStep4View: View {
    
    var formData: TaskFormData
    
    @Query private var items: [ItemModel]
    
    // formData.itemIds에 해당하는 아이템만 필터링
    var filteredItems: [ItemModel] {
        items.filter { item in
            formData.itemIds.contains(item.id)
        }
    }
    
    @State private var showButtons: [Bool] = Array(repeating: false, count: 8) // 최대치 확보
    @State private var isExpanded: Bool = false
    @State private var selectedButton: Int? = nil
    @State private var visibleItem: Int? = nil
    
    
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "M/d"
        return f
    }()
    
    let dayFormatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "E"
        return f
    }()
    
    var body: some View {
        let rawCount = formData.dayCount ?? 0
        let buttonCount: Int = max(rawCount + 1, 1) // 최소 1개 보장
        let distance: CGFloat = 120
        
        
        
        VStack {
            ZStack {
                ForEach(filteredItems, id:\.self) { item in
                    // 중앙 버튼
                    Button(action: {
                        if(selectedButton == item.id){
                            selectedButton = -1
                        } else {
                            selectedButton = item.id
                        }
                    }) {
                        Text(item.title)
                            .padding()
                            .frame(width: 100, height: 50)
                            .foregroundColor(.black)
                            .font(.system(size: 15, weight: .bold, design: .default))
                    }
                    .background(selectedButton == item.id ?
                                Color.init(hex: "0938DF").opacity(0.3).blur(radius: 2) :
                                Color.init(hex: "151515").opacity(0.1).blur(radius: 2))
                    .cornerRadius(20)
                    .draggable("\(item.id)") {
                        // 미리보기로 쓸 뷰를 직접 설정
                        Text(item.title)
                            .padding()
                            .frame(width: 100, height: 50)
                            .background(Color.blue)
                            .cornerRadius(20)
                    }
                    .opacity(visibleItem == item.id ? 1 : 0)
                }

                
                // 주변 버튼들
                ForEach(0..<buttonCount, id: \.self) { index in
                    let angle = Double(index) * (360.0 / Double(buttonCount))
                    let date = Calendar.current.date(byAdding: .day, value: index, to: Date()) ?? Date()
                    let dayString = dayFormatter.string(from: date)
                    
                    let textColor: Color = {
                        if dayString == "Sun" {
                            return .red
                        } else if dayString == "Sat" {
                            return .blue
                        } else {
                            return .black
                        }
                    }()
                    
                    Button(action: {
                        
                    }) {
                        VStack(spacing: 5) {
                            Text(formatter.string(from: date))
                                .font(.system(size: 15, weight: .bold, design: .default))
                            Text(dayString)
                                .font(.system(size: 13, weight: .regular, design: .default))
                        }
                        .foregroundColor(textColor)
                        .rotationEffect(.degrees(-angle))
                    }
                    .padding()
                    .frame(width: 70, height: 100)
                    .background(Color(hex: "151515").opacity(0.1).blur(radius: 2))
                    .cornerRadius(20)
                    .offset(y: showButtons[index] ? -distance : 0)
                    .rotationEffect(.degrees(angle))
                    .opacity(showButtons[index] ? 1 : 0)
                    .animation(.spring(), value: showButtons[index])
                    

                }
                
                HStack(){
                    Button(action: {
                        if let currentId = visibleItem,
                           let currentIndex = filteredItems.firstIndex(where: { $0.id == currentId }) {
                            
                            let nextIndex = (currentIndex + 1) % filteredItems.count
                            let nextItem = filteredItems[nextIndex]
                            
                            visibleItem = nextItem.id
                            selectedButton = nil
                        }
                    }) {
                        Image("leftArrow")
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if let currentId = visibleItem,
                           let currentIndex = filteredItems.firstIndex(where: { $0.id == currentId }) {
                            
                            let previousIndex = (currentIndex - 1 + filteredItems.count) % filteredItems.count
                            let previousItem = filteredItems[previousIndex]
                            
                            visibleItem = previousItem.id
                            selectedButton = nil
                        }
                    }) {
                        Image("rightArrow")
                    }
                }
                .padding()
                .frame(width: 150, height: 50)
                .background(Color.black.opacity(0.3).cornerRadius(50))
                .position(x: UIScreen.main.bounds.width / 2, y: 550)
            }
            
        }
        .onAppear {
            toggleButtons(buttonCount: buttonCount) // 등장하자마자 버튼 열기
            visibleItem = filteredItems.first?.id ?? -1
        }
        
        
        
    }
    
    private func toggleButtons(buttonCount: Int) {
        isExpanded.toggle()
        for i in 0..<buttonCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.05) {
                withAnimation(.spring()) {
                    showButtons[i] = isExpanded
                }
            }
        }
    }
}

#Preview {
    TaskCreateStep4View(formData: TaskFormData())
}
