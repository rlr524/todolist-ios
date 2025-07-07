//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/2/25.
//

import SwiftUI
import SwiftData

@main
struct ToDoListApp: App {
    @State private var store = Store(webService: WebService())
    
    var body: some Scene {
        WindowGroup {
            ListHomeView()
        }.environment(store)
    }
}
