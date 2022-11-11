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
    static var mockInvalidURL = URL(string: "invalid URL")

    static func articleList(withID apiKey: String = Bundle.main.infoDictionary?["API_KEY"] as? String ?? "") -> URL? {
        URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)")
    }
}
