//
//  Models.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/5/25.
//

import Foundation
import SwiftData

enum ItemImportance: String, Codable, CaseIterable, Identifiable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    
    var id: Self { return self }
}

@Model public class Item: Codable, Identifiable, Hashable, ObservableObject {
    enum CodingKeys: CodingKey {
        case id, title, itemDescription, due, importance, complete, owner, deleted
    }
    
    @Attribute(.unique) public var id: String
    var title: String
    var itemDescription: String
    var due: String
    var importance: ItemImportance
    var complete: Bool
    var owner: String
    var deleted: Bool
    
    init(
        id: String,
        title: String,
        itemDescription: String,
        due: String,
        importance: ItemImportance,
        complete: Bool,
        owner: String,
        deleted: Bool
    ) {
        self.id = id
        self.title = title
        self.itemDescription = itemDescription
        self.due = due
        self.importance = importance
        self.complete = complete
        self.owner = owner
        self.deleted = deleted
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        itemDescription = try container.decode(String.self, forKey: .itemDescription)
        due = try container.decode(String.self, forKey: .due)
        importance = try container.decode(ItemImportance.self, forKey: .importance)
        complete = try container.decode(Bool.self, forKey: .complete)
        owner = try container.decode(String.self, forKey: .owner)
        deleted = try container.decode(Bool.self, forKey: .deleted)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(itemDescription, forKey: .itemDescription)
        try container.encode(due, forKey: .due)
        try container.encode(importance, forKey: .importance)
        try container.encode(complete, forKey: .complete)
        try container.encode(owner, forKey: .owner)
        try container.encode(deleted, forKey: .deleted)
    }
}
