//
//  HttpClient.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/4/25.
//

import Foundation

protocol HttpClient {
    var session: URLSession { get }
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T
}
