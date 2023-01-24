//
//  MockTestData.swift
//  NewsArticlesTests
//
//  Created by Akshay Pure on 12/01/23.
//

import XCTest
@testable import NewsArticles

class MockArticleRepository: ArticleRepositoryProtocol {
    func getArticlesFromStub(articleData: NewsArticles.ArticleDataProtocol) {
    }
    
    var apiManager: APIManager
    var mockError: APIError?
    let mockRestAPI: DataRequestProtocol = MockRestAPI()

    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func getArticlesFromDataSource(articleData: ArticleDataProtocol) {
        mockRestAPI.sendDataRequest(requestObject: RequestObj(apiManager: apiManager), completion: { (response: Result<ArticleResponse, APIError>) in
            switch response {
            case .success(let root):
                articleData.populateArticleData(articles: root.articles)
            case .failure(let error):
                self.mockError = error
                articleData.articleRequestFailed(error: error )
                debugPrint(error.localizedDescription)
            }
        })
    }
}

class MockRestAPI: DataRequestProtocol {
    func sendDataRequest<T>(requestObject: RequestObj, completion: @escaping ((Result<T, APIError>) -> Void)) where T: Decodable {
        var responseData: String!
        
        guard URL(string: requestObject.apiManager.url) != nil else {
            completion(.failure(APIError.requestFailure))
            return
        }

        
        switch requestObject.apiManager {
        case.getEmptyArticleList:
            responseData = ArticleDataResources.getFileContents(fileName: ArticleResponseFiles.mockEmptyArticleResponse)
        case .getArticleList:
            responseData = ArticleDataResources.getFileContents(fileName: ArticleResponseFiles.mockValidArticleResponse)
        case .getInvalidResponseData, .getResponseFromInvalidUrl:
            responseData = ArticleDataResources.getFileContents(fileName: ArticleResponseFiles.mockInvalidData)
        case .getNilResponse:
            responseData = nil
        }
        
        if let response = responseData {
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(T.self, from: Data(response.utf8))
                completion(.success(result))
            } catch let error {
                debugPrint(error.localizedDescription)
                completion(.failure(APIError.responseDataError))
            }
        } else {
            completion(.failure(APIError.responseDataError))
        }
    }
}

private struct ArticleResponseFiles {
    static let mockValidArticleResponse = "MockArticlesResponse"
    static let mockEmptyArticleResponse = "EmptyArticleResponse"
    static let mockInvalidData = "MockInvalidData"
}
