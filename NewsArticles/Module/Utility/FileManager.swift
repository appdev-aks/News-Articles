//
//  Filemanager.swift
//  NewsArticles
//
//  Created by Akshay Pure on 23/01/23.
//

import Foundation

struct ArticleResponseFiles {
    static let articlesResponse = "articlesResponse"
}

class ArticleDataResources {
    static func getFileContents(fileName: String) -> String? {
        if let filepath = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
                debugPrint("Data could not be loaded")
            }
        }
        return ""
    }
}
