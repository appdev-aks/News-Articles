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
        mockRestAPI.sendDataRequest(requestObject: RequestObj(apiManager: apiManager), completion: { (response: Result<Data, APIError>) in
            switch response {
            case .success(let result):
                do {
                    let result: ArticleResponse = try Utils.decodeWith(from: result)
                    articleData.populateArticleData(articles: result.articles)
                } catch let error {
                    debugPrint(error.localizedDescription)
                    self.mockError = .responseDataError
                    articleData.articleRequestFailed(error: APIError.responseDataError)
                }
            case .failure(let error):
                self.mockError = error
                articleData.articleRequestFailed(error: error )
                debugPrint(error.localizedDescription)
            }
        })
    }
}

class MockRestAPI: DataRequestProtocol {
    func sendDataRequest(requestObject: RequestObj, completion: @escaping ((Result<Data, APIError>) -> Void)) {
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
            completion(.success(Data(response.utf8)))
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
