//
//  ContentView.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/2/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var results = [Result]()
    
    var body: some View {
        Text("Hello, Madison")
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: K.devBaseURL) else {
            print("Invalid URL")
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("tbd", forHTTPHeaderField: "x-api-key")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
            
            print(results.count)
        } catch {
            print("Invalid data")
        }
    }
}


struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

#Preview {
    ContentView()
}
