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
    @Query private var tasks: [TaskModel]
    @Query private var bombs: [BombModel]
    
    // 입력 필드들
    @State private var categoryTitle = ""
    @State private var categoryUserId = ""
    
    @State private var itemTitle = ""
    @State private var itemColor = ""
    @State private var itemCategoryId = ""
    
    @State private var taskTitle = ""
    @State private var taskColor = ""
    @State private var taskPassword = ""
    @State private var taskItemId = ""
    @State private var taskDayId = ""
    
    @State private var bombPassword = ""
    @State private var bombState = ""
    @State private var bombDayId = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 40) {
                    
                    // Category
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Category").font(.title2).bold()
                        
                        TextField("Title", text: $categoryTitle)
                            .textFieldStyle(.roundedBorder)
                        TextField("UserId (선택)", text: $categoryUserId)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                        
                        Button("카테고리 추가", action: addCategory)
                            .buttonStyle(.borderedProminent)
                        
                        Divider()
                        ForEach(categories) { category in
                            HStack {
                                Text("\(category.title) (userId: \(category.userId?.description ?? "-"))")
                                Spacer()
                                Button(role: .destructive) {
                                    context.delete(category)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                    
                    // Item
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Item").font(.title2).bold()
                        
                        TextField("Title", text: $itemTitle)
                            .textFieldStyle(.roundedBorder)
                        TextField("Color", text: $itemColor)
                            .textFieldStyle(.roundedBorder)
                        TextField("CategoryId (선택)", text: $itemCategoryId)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                        
                        Button("아이템 추가", action: addItem)
                            .buttonStyle(.borderedProminent)
                        
                        Divider()
                        ForEach(items) { item in
                            HStack {
                                Text("\(item.title) (\(item.color))")
                                Spacer()
                                Button(role: .destructive) {
                                    context.delete(item)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                    
                    // Task
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Task").font(.title2).bold()
                        
                        TextField("Title", text: $taskTitle)
                            .textFieldStyle(.roundedBorder)
                        TextField("Color", text: $taskColor)
                            .textFieldStyle(.roundedBorder)
                        TextField("Password(숫자)", text: $taskPassword)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                        TextField("ItemId (선택)", text: $taskItemId)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                        TextField("DayId (선택)", text: $taskDayId)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                        
                        Button("태스크 추가", action: addTask)
                            .buttonStyle(.borderedProminent)
                        
                        Divider()
                        ForEach(tasks) { task in
                            HStack {
                                Text("\(task.title) (\(task.color))")
                                Spacer()
                                Button(role: .destructive) {
                                    context.delete(task)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                    
                    // Bomb
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Bomb").font(.title2).bold()
                        
                        TextField("Password", text: $bombPassword)
                            .textFieldStyle(.roundedBorder)
                        TextField("State(숫자)", text: $bombState)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                        TextField("DayId (선택)", text: $bombDayId)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                        
                        Button("폭탄 추가", action: addBomb)
                            .buttonStyle(.borderedProminent)
                        
                        Divider()
                        ForEach(bombs) { bomb in
                            HStack {
                                Text("\(bomb.password) (state: \(bomb.state))")
                                Spacer()
                                Button(role: .destructive) {
                                    context.delete(bomb)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Admin Panel")
        }
    }
    
    // MARK: - 추가 함수
    private func addCategory() {
        let newCategory = CategoryModel(
            title: categoryTitle,
            userId: Int(categoryUserId)
        )
        context.insert(newCategory)
        categoryTitle = ""
        categoryUserId = ""
    }
    
    private func addItem() {
        let newItem = ItemModel(
            title: itemTitle,
            color: itemColor,
            categoryId: Int(itemCategoryId)
        )
        context.insert(newItem)
        itemTitle = ""
        itemColor = ""
        itemCategoryId = ""
    }
    
    private func addTask() {
        guard let pw = Int(taskPassword) else { return }
        let newTask = TaskModel(
            title: taskTitle,
            color: taskColor,
            password: pw,
            itemId: Int(taskItemId),
            dayId: Int(taskDayId)
        )
        context.insert(newTask)
        taskTitle = ""
        taskColor = ""
        taskPassword = ""
        taskItemId = ""
        taskDayId = ""
    }
    
    private func addBomb() {
        let newBomb = BombModel(
            password: bombPassword,
            state: Int(bombState) ?? 0,
            dayId: Int(bombDayId)
        )
        context.insert(newBomb)
        bombPassword = ""
        bombState = ""
        bombDayId = ""
    }
}

extension Int {
    init?(_ string: String) {
        guard let number = Int(string) else { return nil }
        self = number
    }
}


struct EditableItem: Identifiable {
    let id: Int
    var value: String
}


struct SectionView: View {
    var title: String
    var textFieldPlaceholder: String
    @Binding var text: String
    var onAdd: () -> Void
    var list: [EditableItem]
    var onUpdate: (Int, String) -> Void
    var onDelete: (Int) -> Void
    
    @State private var editingValues: [Int: String] = [:]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.title2)
                .bold()
            
            HStack {
                TextField(textFieldPlaceholder, text: $text)
                    .textFieldStyle(.roundedBorder)
                Button("추가", action: onAdd)
                    .buttonStyle(.borderedProminent)
            }
            
            Divider()
            
            ForEach(list) { item in
                HStack {
                    TextField("", text: Binding(
                        get: { editingValues[item.id, default: item.value] },
                        set: { editingValues[item.id] = $0 }
                    ))
                    .textFieldStyle(.roundedBorder)
                    
                    Button("저장") {
                        if let updated = editingValues[item.id] {
                            onUpdate(item.id, updated)
                        }
                    }
                    .buttonStyle(.bordered)
                    
                    Button(role: .destructive) {
                        onDelete(item.id)
                    } label: {
                        Image(systemName: "trash")
                    }
                }
            }
        }
    }
}

#Preview{
    AdminView()
}
