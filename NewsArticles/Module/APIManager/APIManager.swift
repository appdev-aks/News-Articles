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

enum APIManager: Endpoint {
    case getArticleList(countryCode: String, apiKey: String)
    case getEmptyArticleList
    case getInvalidResponseData
    case getResponseFromInvalidUrl
    case getNilResponse

    var path: String {
        switch self {
        case .getArticleList(let countryCode, let apiKey):
            return "country=\(countryCode)&apiKey=\(apiKey)"
        case .getNilResponse, .getEmptyArticleList, .getInvalidResponseData, .getResponseFromInvalidUrl:
            return ""
        }
    }

    var baseURL: String {
        switch self {
        case .getArticleList:
            return "https://newsapi.org/v2/top-headlines?"
        case .getResponseFromInvalidUrl:
            return "https://newsapi.org /v2/top-headlines?"
        case .getInvalidResponseData, .getEmptyArticleList, .getNilResponse:
            return "http://google.com"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getArticleList:
            return .get
        case .getResponseFromInvalidUrl, .getInvalidResponseData, .getEmptyArticleList, .getNilResponse:
            return .get
        }
    }
    
   // "Unused for implemented APIs"
    var body: String? {
        switch self {
        case .getArticleList, .getResponseFromInvalidUrl, .getInvalidResponseData, .getEmptyArticleList, .getNilResponse:
            return ""
        }
    }
    
   // "Unused for implemented APIs"
    var headers: [String: Any]? {
        switch self {
        case .getArticleList, .getResponseFromInvalidUrl, .getInvalidResponseData, .getEmptyArticleList, .getNilResponse:
                return [:]
        }
    }
    
}
