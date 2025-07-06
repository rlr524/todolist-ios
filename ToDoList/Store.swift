//
//  Store.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/4/25.
//

import Foundation
import Observation

@Observable
class Store {
    let webService: WebService
    private(set) var items: [Item] = []
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func loadItems() async throws {
    }
}
