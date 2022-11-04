//
//  ArticleListViewModel.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

protocol ArticleDataProtocol {
    func populateArticleData(articles: [Article])
    func requestArticles()
}

class ArticleListViewModel {
    
}

extension ArticleListViewModel: ArticleDataProtocol {
    
    func populateArticleData(articles: [Article]) {
        
    }
    
    func requestArticles() {
        
    }
    
    
}
