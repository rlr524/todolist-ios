//
//  AddHomeView.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/6/25.
//

import SwiftUI

struct AddHomeView: View {
    @ObservedObject var item: Item
    @State private var dueDate: Date = Date()
    @State private var importance: ItemImportance = .medium
    
    // Date formatter for converting between Date and String
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
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
                    
                    DatePicker("Due Date", selection: $dueDate,
                               displayedComponents: [.date])
                        .font(.title)
                        .onChange(of: dueDate) { oldValue, newValue in
                            item.due = dateFormatter.string(from: newValue)
                        }
                    
                    Picker("Importance", selection: $importance) {
                        Text("High").tag(ItemImportance.high)
                        Text("Medium").tag(ItemImportance.medium)
                        Text("Low").tag(ItemImportance.low)
                    }
                    .font(.title)
                    .onChange(of: importance) { oldValue, newValue in
                        item.importance = newValue
                    }
                }
            }
        }
        .onAppear {
            // Initialize dueDate from item.due if it contains a valid date
            if let date = dateFormatter.date(from: item.due) {
                dueDate = date
            }
        }
    }
}

#Preview {
    let previewItem: Item = Item(
        id: "",
        title: "",
        itemDescription: "",
        due: "",
        importance: .medium,
        complete: false,
        owner: "",
        deleted: false
    )
    
    AddHomeView(item: previewItem)
        .environment(Store(webService: WebService()))
}
