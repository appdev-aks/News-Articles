//
//  Article.swift
//  News Articles
//
//  Created by Aks_dev on 04/11/22.
//

struct Root: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let urlToImage: String?
    let content: String?
    let description: String?
    let source: Source?
}

struct Source: Decodable {
    let name: String
}
