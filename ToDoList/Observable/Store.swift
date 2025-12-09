//
//  Store.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/4/25.
//
// The Store acts as the ViewModel if an MVVM architecture was being used, however using this
// architecture, which is more akin to a VOODO architecture (View, Observable Object, Data Object)
// it is the Observable class that will hold all logic for handling data loaded from an endpoint.
//
// Keep in mind, because data in this app is being loaded from an API endpoint and needs to
// be available across multiple views, it makes more sense here to have one "ViewModel" type
// file of a reference type that can be used across the app, versus each view having its
// own observable object.
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
                                dataType: [Item].self)
        items = try await webService.load(resource)
    }
    
    func newItem() async throws {
        
    }
}
