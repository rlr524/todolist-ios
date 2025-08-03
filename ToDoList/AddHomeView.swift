//
//  AddHomeView.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/6/25.
//

import SwiftUI

struct AddHomeView: View {
    @ObservedObject var item: Item
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    TextField("Title", text: $item.title,
                              prompt: Text("Enter the todo item title here"))
                        .font(.title)
                    TextField("Description", text: $item.itemDescription,
                              prompt: Text("Enter the todo item description here"))
                        .font(.title)
                }
            }
        }
    }
}

//#Preview {
//    AddHomeView()
//}
