//
//  Article.swift
//  News Articles
//
//  Created by Aks_dev on 04/11/22.
//
// swiftlint:disable identifier_name

struct ArticleResponse: Decodable {
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
    let name: String?
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name, Name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let key = container.allKeys.filter({ CodingKeys.allCases.contains($0) }).first,
            let ids = try container.decodeIfPresent(String.self, forKey: key) {
                self.name = ids
            } else {
                self.name = ""
        }
    }
}
