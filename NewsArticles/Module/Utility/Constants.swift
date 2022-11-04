//
//  Constants.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

extension URL {
    #warning("Move API to separate file and add to gitignore file")
    static func articleList(withID apiKey: String = "946596b9517344ec8bfea9477889e08d") -> URL? {
        URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)")
    }
}

enum APIError: Error {
    case networkConnectionFailed
    case responseDataError
    case unexpectedDataReceived
}

enum StoryBoards {
    static let mainStoryboard = "Main"
    
    enum ViewControllerIdentifier: String {
        case articleList = "HeadlinesViewController"
    }
    
    enum NibFile: String {
        case articleItemCell = "ArticleItemCell"
    }
    
    enum CellIdentifier: String {
        case articleItemCell = "ArticleItemCell"
    }
}
