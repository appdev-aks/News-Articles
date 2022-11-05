//
//  Constants.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

enum APIError: Error {
    case networkConnectionFailed
    case responseDataError
    case requestFailure
}

enum StoryBoards {
    enum StoryboardNames: String {
        case main = "Main"
    }
    
    enum ViewControllerIdentifier: String {
        case articleListController = "ArticleListViewController"
        case articleDetailsController = "ArticleDetailsViewController"
    }
    
    enum NibFile: String {
        case articleItemCell = "ArticleItemCell"
    }
    
    enum CellIdentifier: String {
        case articleItemCell = "ArticleItemCell"
    }
}
