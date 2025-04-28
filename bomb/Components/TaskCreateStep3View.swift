//
//  TaskCreateStep3.View.swift
//  bomb
//
//  Created by emdas93 on 4/27/25.
//
import SwiftUI
import SwiftData
struct TaskCreateStep3View: View {
    
    var formData: TaskFormData;
    @Query private var items: [ItemModel]
    
    @State private var selectedItems: Array<Int> = []
    
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
                    ForEach(items, id: \.self) { item in
                        Button(action: {
                            if let index = selectedItems.firstIndex(of: item.id) {
                                // 이미 선택돼 있으면 제거
                                selectedItems.remove(at: index)
                                if let formIndex = formData.itemIds.firstIndex(of: item.id) {
                                    formData.itemIds.remove(at: formIndex)
                                }
                            } else {
                                // 선택 안 되어 있으면 추가
                                selectedItems.append(item.id)
                                formData.itemIds.append(item.id)
                            }
                        }) {
                            VStack {
                                Text(item.title)
                                    .padding()
                                    .frame(width: 100, height: 50)
                                    .foregroundColor(selectedItems.contains(item.id) ? .white : .black)
                                    .background(selectedItems.contains(item.id) ?
                                                Color.init(hex: "0938DF").opacity(0.3).blur(radius: 2) :
                                                Color.init(hex: "151515").opacity(0.1).blur(radius: 2))
                                    .cornerRadius(20)
                            }
                            
                            
                            .font(.system(size: 15, weight: .bold, design: .default))
                        }
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
        }.onAppear() {
            selectedItems = formData.itemIds
        }
    }
}
