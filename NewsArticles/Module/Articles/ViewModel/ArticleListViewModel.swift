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
    func requestArticlesFromStub()
    func articleRequestFailed(error: APIError)
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
    func requestArticlesFromStub() {
        articleRepositoryProtocol.getArticlesFromStub(articleData: self)
    }
    
    func articleRequestFailed(error: APIError) {
        viewDataSource.showViewForFailedArticleRequest(error: error)
    }
    
    func populateArticleData(articles: [Article]) {
        viewDataSource.articlesReceived(articleList: articles)
    }
    
    func requestArticles() {
        articleRepositoryProtocol.getArticlesFromDataSource(articleData: self)
    }
    
}
