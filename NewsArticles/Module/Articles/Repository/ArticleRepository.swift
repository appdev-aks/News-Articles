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

class ArticleRepository {}

extension ArticleRepository: ArticleRepositoryProtocol {
    func getArticlesFromDataSource(articleData: ArticleDataProtocol) {
        let restServicemanager: DataRequestProtocol = RESTServiceManager()
        restServicemanager.sendDataRequest(requestObject: RequestObj(apiManager: .getArticleList), completion: { (response: Result<ArticleResponse, APIError>) in
            switch response {
            case .success(let root):
                articleData.populateArticleData(articles: root.articles)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                articleData.articleRequestFailed(error: error)
            }
        })
    }
}
