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
    var viewDataSource: ViewDataSource
    var articleRepositoryProtocol: ArticleRepositoryProtocol

    init(viewDataSource: ViewDataSource, articleRepositoryProtocol: ArticleRepositoryProtocol) {
        self.viewDataSource = viewDataSource
        self.articleRepositoryProtocol = articleRepositoryProtocol
    }
}

extension ArticleListViewModel: ArticleDataProtocol {
    
    func populateArticleData(articles: [Article]) {
        
    }
    
    func requestArticles() {
        articleRepositoryProtocol.getArticlesFromDataSource(articleData: self)
    }
    
    
}
