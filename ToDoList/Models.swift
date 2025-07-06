//
//  Models.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/5/25.
//

import Foundation

enum ItemImportance: String, Codable, CaseIterable, Identifiable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    var id: Self { return self }
}

struct Item: Codable, Identifiable, Hashable {
    var id: String
    var title: String
    var description: String
    var due: Date
    var importance: ItemImportance
    var complete: Bool
    var owner: String
    var deleted: Bool
}
