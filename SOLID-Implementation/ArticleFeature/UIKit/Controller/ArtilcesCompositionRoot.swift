//
//  ArtilcesCompositionRoot.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 18/07/2026.
//

import UIKit

enum ArtilcesComposition {
    static func makeViewController() -> UIViewController {
        let cacheLoader = CacheArticleLoader()
        //
        let articlesEndpoint = URL(string: "https://dummyEndpoint.com")!
        let remoteLoader = RemoteArticleLoader(
            client: URLSessionArticlesHTTPClient(),
            url: articlesEndpoint.appendingPathComponent("articles")
        )
        //
        let cacheWriter = CacheWriter()
        
        let articlesLoader = CacheFirstArticleLoader(
            cache: cacheLoader,
            remote: remoteLoader,
            cacheWriter: cacheWriter
        )
        let viewModel = ArticlesViewModel(loader: articlesLoader)
        let articlesViewController = ArticlesViewController(viewModel: viewModel)
        
        let navigationController = UINavigationController(rootViewController: articlesViewController)
        articlesViewController.tabBarItem.title = "Articles"
        
        return navigationController
    }
}

struct CacheWriter: ArticleCacheWriter {
    func save(_ articles: [Article]) async throws {
        //TODO: -
    }
}
