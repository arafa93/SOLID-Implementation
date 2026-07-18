//
//  URLSessionArticlesHTTPClient.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 18/07/2026.
//

import Foundation

final class URLSessionArticlesHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func get(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw HTTPCLientError.invalidResponse
        }
        
        return data
    }
}
