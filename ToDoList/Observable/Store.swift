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


/// A centralized store for managing to-do list items.
///
/// `Store` acts as the observable data layer in a VOODO (View, Observable Object, Data Object) architecture.
/// It manages the application's state and coordinates data loading operations through a `WebService`.
/// Being a reference type, it can be shared across multiple views while maintaining a single source of truth.
///
/// ## Topics
///
/// ### Creating a Store
///
/// - ``init(webService:)``
///
/// ### Managing Items
///
/// - ``items``
/// - ``loadItems()``
/// - ``newItem()``
///
/// ### Dependencies
///
/// - ``webService``
///
@Observable
class Store {
    
    /// The web service used to communicate with the API endpoint.
    ///
    /// This service handles all network operations for loading and manipulating to-do items.
    let webService: WebService
    
    /// The collection of to-do items managed by this store.
    ///
    /// This array is populated by calling ``loadItems()`` and can be observed by SwiftUI views
    /// for automatic UI updates. The setter is private to ensure items can only be modified
    /// through the store's methods.
    private(set) var items: [Item] = []
    
    /// Creates a new store with the specified web service.
    ///
    /// - Parameter webService: The web service to use for API communication.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let webService = WebService()
    /// let store = Store(webService: webService)
    /// ```
    init(webService: WebService) {
        self.webService = webService
    }
    
    /// Loads all to-do items from the API endpoint.
    ///
    /// This method fetches the complete list of items from the server and updates
    /// the ``items`` property. The UI will automatically refresh due to the `@Observable` macro.
    ///
    /// - Throws: An error if the network request fails or the response cannot be decoded.
    ///
    /// ## Example
    ///
    /// ```swift
    /// do {
    ///     try await store.loadItems()
    /// } catch {
    ///     print("Failed to load items: \(error)")
    /// }
    /// ```
    func loadItems() async throws {
        let resource = Resource(url: K.URLs.getItems(),
                                method: .get,
                                dataType: [Item].self)
        items = try await webService.load(resource)
    }
    
    /// Creates a new to-do item.
    ///
    /// - Note: This method is not yet implemented.
    ///
    /// - Throws: An error if the item creation fails.
    func newItem() async throws {
        
    }
}
