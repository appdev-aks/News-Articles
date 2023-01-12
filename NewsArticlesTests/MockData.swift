//
//  MockTestData.swift
//  NewsArticlesTests
//
//  Created by Akshay Pure on 12/01/23.
//

import XCTest
@testable import NewsArticles

class MockArticleRepository: ArticleRepositoryProtocol {
    var apiManager: APIManager
    var mockError: APIError?
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func getArticlesFromDataSource(articleData: ArticleDataProtocol) {
        let mockRestAPI: DataRequestProtocol = MockRestAPI()
        mockRestAPI.sendDataRequest(requestObject: RequestObj(apiManager: apiManager), completion: { (response: Result<Root, APIError>) in
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
        if requestObject.apiManager.getURL() != nil {
            var responseData: String!
            
            switch requestObject.apiManager {
            case.getEmptyMockArticleList:
                responseData = MockDataResources.getFileContents(fileName: ArticleResponseFiles.mockEmptyArticleResponse)
            case .getArticleList:
                responseData = MockDataResources.getFileContents(fileName: ArticleResponseFiles.mockValidArticleResponse)
            case .getMockInvalidResponse, .getResponseFromInvalidUrl:
                responseData = MockDataResources.getFileContents(fileName: ArticleResponseFiles.mockInvalidData)
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
        } else {
            completion(.failure(APIError.requestFailure))
        }
    }
}

private struct ArticleResponseFiles {
    static let mockValidArticleResponse = "MockArticlesResponse"
    static let mockEmptyArticleResponse = "EmptyArticleResponse"
    static let mockInvalidData = "MockInvalidData"
}

class MockDataResources {
    
    static func getFileContents(fileName: String) -> String? {
        if let filepath = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let contents = try String(contentsOfFile: filepath)
                return contents
            } catch {
                debugPrint("Article could not be loaded")
            }
        }
        return ""
    }
}

