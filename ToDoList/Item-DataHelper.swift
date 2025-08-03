//
//  Item-DataHelper.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/10/25.
//

import Foundation
import SwiftUI

extension Item {
    static var example: Item {
        let store = Store(webService: WebService)
        
        item.title = "Example item"
        item.itemDescription = "Example description"
        item.due = "Example date"
        item.importance = .low
        item.owner = "Example owner"
        item.deleted = false
        item.complete = false
    }
}


