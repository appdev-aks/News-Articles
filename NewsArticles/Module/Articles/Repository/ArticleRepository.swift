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

class ArticleRepository {}

extension ArticleRepository: ArticleRepositoryProtocol {
    func getArticlesFromStub(articleData: ArticleDataProtocol) {
        let responseData = MockDataResources.getFileContents(fileName: ArticleResponseFiles.articlesResponse)
        
        if let response = responseData {
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(ArticleResponse.self, from: Data(response.utf8))
                articleData.populateArticleData(articles: result.articles)
            } catch let error {
                debugPrint(error.localizedDescription)
                articleData.articleRequestFailed(error: APIError.responseDataError)
            }
        } else {
            articleData.articleRequestFailed(error: APIError.responseDataError)
        }
    }
    
    func getArticlesFromDataSource(articleData: ArticleDataProtocol) {
        let restServicemanager: DataRequestProtocol = RESTServiceManager()
        restServicemanager.sendDataRequest(requestObject: RequestObj(apiManager: .getArticleList), completion: { (response: Result<ArticleResponse, APIError>) in
            switch response {
            case .success(let articleResponse):
                articleData.populateArticleData(articles: articleResponse.articles)
            case .failure(let error):
                debugPrint(error.localizedDescription)
                articleData.articleRequestFailed(error: error)
            }
        })
    }
}
