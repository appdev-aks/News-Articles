//
//  APIManager.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

struct RequestObj {
    var apiManager: APIManager
}

enum APIManager {
    case getArticleList
    
    func getURL() -> URL? {
        switch self {
        case .getArticleList:
            return URL.articleList()
        }
    }
}
