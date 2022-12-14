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
    case getEmptyMockArticleList
    case getMockInvalidResponse
    case getResponseFromInvalidUrl
    case getNilResponse

    func getURL() -> URL? {
        switch self {
        case .getArticleList:
            return URL.articleList()
        case .getNilResponse, .getEmptyMockArticleList, .getMockInvalidResponse:
            return URL.mockURL
        case .getResponseFromInvalidUrl:
            return URL.mockInvalidURL
        }
    }
}
