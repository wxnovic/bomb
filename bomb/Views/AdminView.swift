//
//  AdminView.swift
//  zota
//
//  Created by emdas93 on 4/27/25.
//

import SwiftUI
import SwiftData

struct AdminView: View {
    @Environment(\.modelContext) private var context
    
    @Query private var categories: [CategoryModel]
    @Query private var items: [ItemModel]
    
    @State private var categoryName: String = ""
    
    @State private var itemName: String = ""
    @State private var itemColor: String = "000000"
    @State private var itemCategoryId: Int? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                
                // ------------------------
                // 카테고리 추가
                // ------------------------
                SectionBox(title: "카테고리 추가") {
                    TextField("카테고리 이름", text: $categoryName)
                        .textFieldStyle(.roundedBorder)
                    
                    Button(action: addCategory) {
                        Text("카테고리 추가")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                
                // ------------------------
                // 카테고리 리스트
                // ------------------------
                SectionBox(title: "카테고리 목록") {
                    if categories.isEmpty {
                        Text("등록된 카테고리가 없습니다.")
                            .foregroundColor(.gray)
                    } else {
                        List {
                            ForEach(categories) { category in
                                VStack(alignment: .leading) {
                                    Text(category.title)
                                        .font(.headline)
                                    Text("ID: \(category.id)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .onDelete(perform: deleteCategories)
                        }
                        .frame(height: 300)
                        .listStyle(.plain)
                    }
                }
                
                // ------------------------
                // 아이템 추가
                // ------------------------
                SectionBox(title: "아이템 추가") {
                    TextField("아이템 이름", text: $itemName)
                        .textFieldStyle(.roundedBorder)
                    
                    TextField("색상 (예: FF0000)", text: $itemColor)
                        .textFieldStyle(.roundedBorder)
                    
                    Picker("카테고리 선택", selection: $itemCategoryId) {
                        Text("카테고리 없음").tag(Int?.none) // 선택 안 한 경우
                        
                        ForEach(categories) { category in
                            Text("\(category.title) (ID: \(category.id))")
                                .tag(Int?.some(category.id))
                        }
                    }
                    .pickerStyle(.menu) // 드롭다운 스타일
                    
                    Button(action: addItem) {
                        Text("아이템 추가")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }

                
                // ------------------------
                // 아이템 리스트
                // ------------------------
                SectionBox(title: "아이템 목록") {
                    if items.isEmpty {
                        Text("등록된 아이템이 없습니다.")
                            .foregroundColor(.gray)
                    } else {
                        List {
                            ForEach(items) { item in
                                VStack(alignment: .leading) {
                                    Text(item.title)
                                        .font(.headline)
                                    Text("ID: \(item.id) / 색상: #\(item.color) / 카테고리 ID: \(item.categoryId?.description ?? "없음")")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                        .frame(height: 300)
                        .listStyle(.plain)
                    }
                }
                
            }
            .padding()
        }
    }
    
    // ------------------------
    // 카테고리 추가
    // ------------------------
    private func addCategory() {
        guard !categoryName.isEmpty else { return }
        
        let newCategory = CategoryModel(
            id: (categories.map { $0.id }.max() ?? -1) + 1,
            title: categoryName
        )
        context.insert(newCategory)
        try? context.save()
        
        categoryName = ""
    }
    
    // ------------------------
    // 아이템 추가
    // ------------------------
    private func addItem() {
        guard !itemName.isEmpty else { return }
        
        let newItem = ItemModel(
            id: (items.map { $0.id }.max() ?? -1) + 1,
            title: itemName,
            color: itemColor,
            categoryId: itemCategoryId
        )
        context.insert(newItem)
        try? context.save()
        
        itemName = ""
        itemColor = "000000"
        itemCategoryId = nil
    }
    
    // ------------------------
    // 삭제 함수
    // ------------------------
    private func deleteCategories(at offsets: IndexSet) {
        for index in offsets {
            context.delete(categories[index])
        }
        try? context.save()
    }
    
    private func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            context.delete(items[index])
        }
        try? context.save()
    }
}

// ------------------------
// 공통 섹션 박스 뷰
// ------------------------
@ViewBuilder
private func SectionBox<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
    VStack(alignment: .leading, spacing: 10) {
        Text(title)
            .font(.title3)
            .bold()
        
        content()
    }
    .padding()
    .background(Color(UIColor.secondarySystemBackground))
    .cornerRadius(12)
}
