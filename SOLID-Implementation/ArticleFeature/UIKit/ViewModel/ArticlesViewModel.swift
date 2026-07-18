//
//  ArticlesViewModel.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 18/07/2026.
//

import Foundation

enum LoadArticlesError: Error {
    case failed
}

@MainActor
final class ArticlesViewModel {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded([Article])
        case empty
        case failed(LoadArticlesError)
    }
    
    private let loader: ArticleLoader
    
    private(set) var state: State = .idle {
        didSet {
            onChangeState?(state)
        }
    }
    
    var onChangeState: ((State) -> Void)?
    
    init(loader: ArticleLoader) {
        self.loader = loader
    }
    
    func load() {
        Task {
            state = .loading
            
            do {
                let articles = try await loader.loadArticles()
                
                guard !articles.isEmpty else {
                    state = .empty
                    return
                }
                
                state = .loaded(articles)
            } catch {
                state = .failed(LoadArticlesError.failed)
            }
        }
    }
}
