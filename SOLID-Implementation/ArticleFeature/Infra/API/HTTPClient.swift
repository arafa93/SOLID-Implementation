//
//  HTTPClient.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 18/07/2026.
//

import Foundation

protocol HTTPClient {
    func get(from url: URL) async throws -> Data
}

enum HTTPCLientError: Error {
    case invalidResponse
}
