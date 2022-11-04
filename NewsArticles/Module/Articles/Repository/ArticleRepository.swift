//
//  ArticleRepository.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

protocol ArticleRepositoryProtocol {
    func getArticlesFromDataSource(articleData: ArticleDataProtocol)
}

class ArticleRepository {
    
}

extension ArticleRepository: ArticleRepositoryProtocol {
    func getArticlesFromDataSource(articleData: ArticleDataProtocol) {
        
    }
}
