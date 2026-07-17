//
//  ProfileAPIClient.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 16/07/2026.
//

import Foundation

protocol ProfileAPIClient: Sendable {
    func fetchProfile() async throws -> Profile
}

enum APIError: Error {
    case invalidResponse
}

final class URLSessionProfileAPIClient: ProfileAPIClient {
    
    private let session: URLSession
    private let url: URL
    
    init(session: URLSession = .shared, url: URL) {
        self.session = session
        self.url = url
    }
    
    func fetchProfile() async throws -> Profile {
        let url = url.appendingPathComponent("profile")
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw APIError.invalidResponse
        }
        
        return try JSONDecoder().decode(
            Profile.self,
            from: data
        )
    }
}
