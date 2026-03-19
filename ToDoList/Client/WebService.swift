//
//  WebService.swift
//  ToDoList
//
//  Created by Rob Ranf on 7/4/25.
//
// The WebService file contains all networking code for the application.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError(Error)
    case invalidResponse
    case errorResponse(ErrorResponse)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badRequest:
            return NSLocalizedString("Bad Request (400): Unable to perform the request",
                                     comment: "badRequestError")
        case .decodingError (let error):
            return NSLocalizedString(
                "Unable to decode successfully \(error.localizedDescription)",
                comment: "decodingError"
            )
        case .invalidResponse:
            return NSLocalizedString("Invalid response", comment: "invalidResponse")
        case .errorResponse(let errorResponse):
            return NSLocalizedString("Error \(errorResponse.message ?? "")",
                                     comment: "errorResponse")
        }
    }
}

enum HTTPMethod {
    case get
    case post(Data?)
    case delete
    case put(Data?)
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        case .put:
            return "PUT"
        }
    }
}

struct Resource<T: Codable> {
    let url: URL
    var method: HTTPMethod = .get
    var headers: [String: String]? = nil
    var dataType: T.Type
}

struct ErrorResponse: Codable {
    let message: String?
}

struct WebService: HttpClient {
    internal let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        self.session = URLSession(configuration: config)
    }
    
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        
        let components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
        guard let url = components?.url else {
            throw NetworkError.badRequest
        }
        request.url = url
        
        // Set custom headers
        if let headers = resource.headers {
            for (v, k) in headers {
                request.setValue(v, forHTTPHeaderField: k)
            }
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Check for specific HTTP errors
        switch httpResponse.statusCode {
        case 200...299:
            break //Success
        default:
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw NetworkError.errorResponse(errorResponse)
        }
        
        do {
            let result = try JSONDecoder().decode(resource.dataType, from: data)
            return result
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    /// Creates a new resource on the server.
    ///
    /// This method sends a POST request with the provided resource data and returns
    /// the created resource from the server response.
    ///
    /// - Parameter resource: The resource configuration including URL, method (POST), and data type.
    /// - Returns: The created resource as returned by the server.
    /// - Throws: A `NetworkError` if the request fails or the response cannot be decoded.
    ///
    /// ## Example
    ///
    /// ```swift
    /// let resource = Resource(
    ///     url: K.URLs.createItem(),
    ///     method: .post(encodedItemData),
    ///     dataType: Item.self
    /// )
    /// let createdItem = try await webService.create(resource)
    /// ```
    func create<T: Codable>(_ resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        
        // Set the HTTP method
        switch resource.method {
        case .post(let data):
            request.httpMethod = HTTPMethod.post(data).name
            request.httpBody = data
        default:
            throw NetworkError.badRequest
        }
        
        // Set custom headers
        if let headers = resource.headers {
            for (v, k) in headers {
                request.setValue(v, forHTTPHeaderField: k)
            }
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        // Check for specific HTTP errors
        switch httpResponse.statusCode {
        case 200...299:
            break // Success
        default:
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            throw NetworkError.errorResponse(errorResponse)
        }
        
        do {
            let result = try JSONDecoder().decode(resource.dataType, from: data)
            return result
        } catch {
            throw NetworkError.decodingError(error)
        }
    }
    
    
}
