//
//  ArticleLoader.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 18/07/2026.
//

import Foundation

protocol ArticleLoader {
    func loadArticles() async throws -> [Article]
}

final class RemoteArticleLoader: ArticleLoader {
    
    private let client: HTTPClient
    private let endpoint: URL
    
    init(client: HTTPClient, url: URL) {
        self.client = client
        self.endpoint = url
    }
    
    func loadArticles() async throws -> [Article] {
        let data = try await client.get(from: endpoint)
        
        let articles = try JSONDecoder().decode(
            [ArticleDTO].self,
            from: data
        )
        
        return articles.map { $0.article }
    }
}
