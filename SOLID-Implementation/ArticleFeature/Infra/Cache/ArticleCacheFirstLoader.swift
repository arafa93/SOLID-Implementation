//
//  ArticleCache.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 18/07/2026.
//

import Foundation

protocol ArticleCache {
    func loadArticles() async throws -> [Article]
    func save(_ articles: [Article]) async throws
}

protocol ArticleCacheWriter {
    func save(_ articles: [Article]) async throws
}

final class CacheFirstArticleLoader: ArticleLoader {
    
    private let cache: ArticleLoader
    private let remote: ArticleLoader
    private let cacheWriter: ArticleCacheWriter
    
    init(
        cache: ArticleLoader,
        remote: ArticleLoader,
        cacheWriter: ArticleCacheWriter
    ) {
        self.cache = cache
        self.remote = remote
        self.cacheWriter = cacheWriter
    }
    
    func loadArticles() async throws -> [Article] {
        if let cachedArticles = try? await cache.loadArticles(),
           !cachedArticles.isEmpty {
            return cachedArticles
        }
        
        let remoteCached = try await remote.loadArticles()
        
        try? await cacheWriter.save(remoteCached)
        
        return remoteCached
    }
}
