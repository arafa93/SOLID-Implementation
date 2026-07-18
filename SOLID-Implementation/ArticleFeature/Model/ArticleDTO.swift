//
//  ArticleDTO.swift
//  SOLID-Implementation
//
//  Created by Mohamed Arafa on 18/07/2026.
//

import Foundation

struct ArticleDTO: Decodable {
    let id: UUID
    let title: String
    let body: String
    
    var article: Article {
        Article(id: id, title: title, body: body)
    }
}
