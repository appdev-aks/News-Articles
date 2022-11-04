//
//  ArticleRepository.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

protocol ArticleRepositoryProtocol {
    func getArticlesFromAPI(networkAPI: ArticleDataProtocol)
}

class Repository {
    
}

extension Repository: ArticleRepositoryProtocol {
    func getArticlesFromAPI(networkAPI: ArticleDataProtocol) {
        
    }
}
