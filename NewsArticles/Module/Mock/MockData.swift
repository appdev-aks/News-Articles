//
//  MockData.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

class MockArticleRepository: ArticleRepositoryProtocol {
    var apiManager: APIManager
    var mockError: Error?
    
    init(apiManager: APIManager) {
        self.apiManager = apiManager
    }
    
    func getArticlesFromDataSource(articleData: ArticleDataProtocol) {
        let mockRestAPI: DataRequestProtocol = MockRestAPI()
        mockRestAPI.sendDataRequest(requestObject: RequestObj(apiManager: apiManager), callback: { (response: Result<Root, Error>) in
            switch response {
            case .success(let root):
                articleData.populateArticleData(articles: root.articles)
            case .failure(let error):
                self.mockError = error
                articleData.articleRequestFailed()
                debugPrint(error.localizedDescription)
            }
        })
    }
}

class MockRestAPI: DataRequestProtocol {
    func sendDataRequest<T>(requestObject: RequestObj, callback: @escaping ((Result<T, Error>) -> ())) where T : Decodable {
        
        var responseData: String!
        
        switch requestObject.apiManager {
        case .getValidMockArticleList:
            responseData = MockDataResources.getFileContents(fileName: ArticleResponseFiles.mockValidArticleResponse)
        case.getEmptyMockArticleList:
            responseData = MockDataResources.getFileContents(fileName: ArticleResponseFiles.mockEmptyArticleResponse)
        case .getArticleList:
            responseData = MockDataResources.getFileContents(fileName: ArticleResponseFiles.mockValidArticleResponse)
        case .getMockInvalidResponse:
            responseData = MockDataResources.getFileContents(fileName: ArticleResponseFiles.mockInvalidData)
        case .getNilResponse:
            responseData = nil
        }
        
        if let response = responseData {
            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(T.self, from: Data(response.utf8))
                callback(.success(result))
            } catch let error {
                debugPrint(error.localizedDescription)
                callback(.failure(APIError.unexpectedDataReceived))
            }
        }else {
            callback(.failure(APIError.responseDataError))
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
        } else {
            debugPrint("File not found")
        }
        return ""
    }
}
