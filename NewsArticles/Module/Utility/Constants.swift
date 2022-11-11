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
    
    func getErrorMessage() -> String {
        switch self {
        case .networkConnectionFailed:
            return NSLocalizedString("networkConnectionError", comment: "")
        case .responseDataError:
            return NSLocalizedString("responseDataError", comment: "")
        case .requestFailure:
            return NSLocalizedString("requestFailure", comment: "")
        }
    }
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
