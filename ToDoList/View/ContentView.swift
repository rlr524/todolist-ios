//
//  ContentView.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/2/25.
//

import SwiftUI

struct Response: Codable {
    var results: [Item]
}

struct ContentView: View {
    @State private var showingAddForm = false
    @Environment(Store.self) var store
    
    var body: some View {
        List(store.items) {item in
            Text(item.title)
        }.task {
            do {
                try await store.loadItems()
            } catch {
                print(error)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    showingAddForm = true
                }) {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
            }
        }
        .sheet(isPresented: $showingAddForm) {
            AddHomeView(
                item: Item(
                    id: "",
                    title: "",
                    itemDescription: "",
                    due: "",
                    importance: .low,
                    complete: false,
                    owner: "",
                    deleted: false
                )
            )
        }
    }
}

#Preview {
    ContentView()
        .environment(Store(webService: WebService()))
}

