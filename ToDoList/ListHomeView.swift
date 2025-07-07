//
//  ListHomeView.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/4/25.
//

import SwiftUI

struct ListHomeView: View {
    @Environment(Store.self) private var store
    
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
    }
}

#Preview {
    ListHomeView().environment(Store(webService: WebService()))
}
