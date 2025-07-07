//
//  Constants.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/5/25.
//

import Foundation
import SwiftUI

struct K {
    static let environment: String = "dev"
    static let version: String = "v1"
    static let devBaseURL: String = "http://localhost:3000/api/\(version)"
    static let prodBaseURL: String = ""
    static let baseUrl: String = environment == "dev" ? devBaseURL : prodBaseURL
    
    struct URLs {
        static func getItems() -> URL {
            return URL(string: "\(baseUrl)/items")!
        }
        
        static func getItemById(id: String) -> URL {
            return URL(string: "\(baseUrl)/item/\(id)")!
        }
        
        static func createItem() -> URL {
            return URL(string: "\(baseUrl)/item")!
        }
        
        static func updateItem() -> URL {
            return URL(string: "\(baseUrl)/item")!
        }
        
        static func deleteItem(id: String) -> URL {
            return URL(string: "\(baseUrl)/item/\(id)")!
        }
    }
}
