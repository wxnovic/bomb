//
//  Models.swift
//  zota
//
//  Created by emdas93 on 4/24/25.
//

import Foundation
import SwiftData

// MARK: - Category
@Model
final class CategoryModel {
    @Attribute(.unique) var id: Int
    var title: String
    var createdAt: Date
    var updatedAt: Date

    init(id: Int, title: String) {
        self.id = id
        self.title = title
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
    }
}

// MARK: - Item
@Model
final class ItemModel {
    @Attribute(.unique) var id: Int
    var title: String
    var color: String
    var createdAt: Date
    var updatedAt: Date
    var categoryId: Int?
    var isDeleted: Bool = false

    init(id: Int, title: String, color: String = "000000", categoryId: Int? = nil) {
        self.id = id
        self.title = title
        self.color = color
        self.categoryId = categoryId
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
    }
}

// MARK: - Task
@Model
final class TaskModel {
    @Attribute(.unique) var id: Int
    var title: String
    var color: String
    var isDone: Bool
    var password: Int
    var createdAt: Date
    var updatedAt: Date
    var itemId: Int?
    var dayId: Int?

    init(id: Int, title: String, color: String, isDone: Bool = false, password: Int, itemId: Int? = nil, dayId: Int? = nil) {
        self.id = id
        self.title = title
        self.color = color
        self.isDone = isDone
        self.password = password
        self.itemId = itemId
        self.dayId = dayId
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
    }
}

// MARK: - Bomb
@Model
final class BombModel {
    @Attribute(.unique) var id: Int
    var password: String
    var state: Int
    var createdAt: Date
    var updatedAt: Date
    var dayId: Int?

    init(id: Int, password: String, state: Int = 0, dayId: Int? = nil) {
        self.id = id
        self.password = password
        self.state = state
        self.dayId = dayId
        let now = Date()
        self.createdAt = now
        self.updatedAt = now
    }
}
