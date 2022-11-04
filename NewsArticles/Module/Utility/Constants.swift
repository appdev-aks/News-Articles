//
//  Constants.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

extension URL {
    static func articleList(withID apiKey: String = "") -> URL? {
        URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)")
    }
}

enum APIError: Error {
    case networkConnectionFailed
    case responseDataError
    case unexpectedDataReceived
}

