//
//  MockData.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

class MockArticleRepository: ArticleRepositoryProtocol {
    
    func getArticlesFromDataSource(articleData: ArticleDataProtocol) {
        let mockRestAPI: DataRequestProtocol = MockRestAPI()
        mockRestAPI.sendDataRequest(requestObject: RequestObj(apiManager: .getArticleList), callback: { (response: Result<Root, Error>) in
            switch response {
            case .success(let root):
                articleData.populateArticleData(articles: root.articles)
            case .failure(let error):
                debugPrint(error.localizedDescription)
            }
        })
    }
}

class MockRestAPI: DataRequestProtocol {
    func sendDataRequest<T>(requestObject: RequestObj, callback: @escaping ((Result<T, Error>) -> ())) where T : Decodable {
        let articles = Array.init(repeating: Article( title: "name", urlToImage: "", content: "", description: "", source: Source(name: "Google")), count: 5)
        let root: Decodable = Root(articles: articles)
        callback(.success(root as! T))
    }
}
