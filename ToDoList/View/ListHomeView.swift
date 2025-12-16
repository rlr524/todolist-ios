//
//  ListHomeView.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/4/25.
//

import SwiftUI
import SwiftData

struct Response: Codable {
    var results: [Item]
}


struct ListHomeView: View {
    @Environment(Store.self) private var store
    
    var body: some View {
        Text("Hello, Madison")
        List(store.items) {item in
            Text(item.title)
        }.task {
            do {
                try await store.loadItems()
            } catch {
                print(error)
            }
        }
    }
}


#Preview {
    ListHomeView().environment(Store(webService: WebService()))
}

