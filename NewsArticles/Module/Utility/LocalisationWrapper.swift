//
//  LocalisationWrapper.swift
//  NewsArticles
//
//  Created by Akshay Pure on 23/01/23.
//

import Foundation

struct Localization {
    struct ArticleList {
        static let screenTitle = NSLocalizedString("ArticleListTitle", comment: "Title for article list")
    }
    
    struct Error {
        static let networkConnectionError = NSLocalizedString("networkConnectionError", comment: "")
        static let responseDataError = NSLocalizedString("responseDataError", comment: "")
        static let requestFailure = NSLocalizedString("requestFailure", comment: "")
    }
    
    struct JailBroken {
        static let jailBrokenTitle = NSLocalizedString("jailBrokenTitle", comment: "")
        static let jailBrokenSubTitle = NSLocalizedString("jailBrokenSubTitle", comment: "")
        
    }
}
