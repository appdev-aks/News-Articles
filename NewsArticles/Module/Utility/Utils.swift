//
//  Utils.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}

extension URL {
    static var mockURL = URL(string: "http://mockurl.com")
    
    #warning("Move API to separate file and add to gitignore file")
    static func articleList(withID apiKey: String = "946596b9517344ec8bfea9477889e08d") -> URL? {
        URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)")
    }
}
