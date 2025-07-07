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
        let resource = Resource(url: K.URLs.getItems(),
                                method: .get,
                                headers: ["nazdub-maDnin-6qindy": "x-api-key"],
                                dataType: [Item].self)
        items = try await webService.load(resource)
    }
    
    func newItem() async throws {
        
    }
}
