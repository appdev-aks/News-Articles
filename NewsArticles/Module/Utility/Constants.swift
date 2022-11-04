//
//  Constants.swift
//  NewsArticles
//
//  Created by Akshay Pure on 04/11/22.
//

import Foundation

extension URL {
    static func articleList(withID apiKey: String = "") -> URL? {
        URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)")
    }
}
