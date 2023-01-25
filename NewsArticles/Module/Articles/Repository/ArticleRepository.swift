//
//  ArticleRepository.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

protocol ArticleRepositoryProtocol {
    func getArticlesFromDataSource(articleData: ArticleDataProtocol)
    func getArticlesFromStub(articleData: ArticleDataProtocol)

}

class ArticleRepository: ArticleRepositoryProtocol {
    let restServicemanager: DataRequestProtocol = RESTServiceManager()

    func getArticlesFromStub(articleData: ArticleDataProtocol) {
        let response = ArticleDataResources.getFileContents(fileName: ArticleResponseFiles.articlesResponse)
        
        if let response = response {
            do {
                let result: ArticleResponse = try Utils.decodeWith(from: Data(response.utf8))
                articleData.populateArticleData(articles: result.articles)
            } catch let error {
                debugPrint(error.localizedDescription)
                articleData.articleRequestFailed(error: APIError.responseDataError)
            }
        }
    }
    
    func getArticlesFromDataSource(articleData: ArticleDataProtocol) {
        let requestObject = RequestObj(apiManager: .getArticleList(countryCode: APIConstants.countryCode, apiKey: APIConstants.apiKey))
        restServicemanager.sendDataRequest(requestObject: requestObject, completion: { (response: Result<Data, APIError>) in
            switch response {
            case .success(let articleResponse):
                do {
                    let result: ArticleResponse = try Utils.decodeWith(from: articleResponse)
                    articleData.populateArticleData(articles: result.articles)
                } catch let error {
                    debugPrint(error.localizedDescription)
                    articleData.articleRequestFailed(error: APIError.responseDataError)
                }
            case .failure(let error):
                debugPrint(error.localizedDescription)
                articleData.articleRequestFailed(error: error)
            }
        })
    }
}
