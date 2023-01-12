//
//  News_ArticlesTests.swift
//  News ArticlesTests
//
//  Created by Aks_dev on 03/11/22.
//

import XCTest
@testable import NewsArticles

final class NewsArticlesTests: XCTestCase {
    private var testSut: ArticleListViewModel!
    private var articleListView: ArticleListViewController!

    override func setUpWithError() throws {
        guard let controller = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ArticleListViewController") as? ArticleListViewController else {
            return XCTFail("Failed to instantiate ViewController from main storyboard")
        }
        articleListView = controller
        testSut = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: MockArticleRepository(apiManager: .getArticleList))
    }
                                       
    func testArticleDataFlowForRequestAndResponse() throws {
        let exp = expectation(description: "Get articles from response")
        articleListView.loadViewIfNeeded()
        let mockRepo = MockArticleRepository(apiManager: .getArticleList)
        articleListView.viewModel = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: mockRepo)
        articleListView.viewModel.requestArticles()
        exp.fulfill()
        waitForExpectations(timeout: 1)
        XCTAssertEqual(articleListView.articleItemList.count, 7, "Expected number of articles received")
    }
    
    func testEmptyArticleDataResponse() throws {
        let exp = expectation(description: "Get zero articles if array is empty")
        articleListView.loadViewIfNeeded()
        let mockRepo = MockArticleRepository(apiManager: .getEmptyMockArticleList)
        articleListView.viewModel = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: mockRepo)
        articleListView.viewModel.requestArticles()
        exp.fulfill()
        waitForExpectations(timeout: 1)
        XCTAssertEqual(articleListView.articleItemList.count, 0, "Received zero results")
    }
    
    func testNilDataResponse() throws {
        let exp = expectation(description: "Get valid error for nil response")
        articleListView.loadViewIfNeeded()
        let mockRepo = MockArticleRepository(apiManager: .getNilResponse)
        articleListView.viewModel = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: mockRepo)
        articleListView.viewModel.requestArticles()
        exp.fulfill()
        waitForExpectations(timeout: 1)
        XCTAssertEqual(articleListView.errorMessage, APIError.responseDataError.getErrorMessage(),"Valid error received for nil response")
        XCTAssertEqual(articleListView.articleItemList.count, 0)
    }


    func testInvalidArticleDataResponse() throws {
        let exp = expectation(description: "Get error for invalid response")
        articleListView.loadViewIfNeeded()
        let mockRepo = MockArticleRepository(apiManager: .getMockInvalidResponse)
        articleListView.viewModel = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: mockRepo)
        
        articleListView.viewModel.requestArticles()
        exp.fulfill()
        waitForExpectations(timeout: 1)
        XCTAssertEqual(articleListView.errorMessage, APIError.responseDataError.getErrorMessage())
        XCTAssertNotNil(mockRepo.mockError)
        XCTAssertEqual(articleListView.articleItemList.count, 0)
    }
    
    func testMockArticleRepositoryForURL() throws {
        let exp = expectation(description: "Get error for invalid response")
        articleListView.loadViewIfNeeded()
        let mockRepo = MockArticleRepository(apiManager: .getResponseFromInvalidUrl)
        articleListView.viewModel = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: mockRepo)
        articleListView.viewModel.requestArticles()
        exp.fulfill()
        waitForExpectations(timeout: 1)
        XCTAssertNotNil(mockRepo.mockError)
        XCTAssertEqual(articleListView.errorMessage, APIError.requestFailure.getErrorMessage())
        XCTAssertEqual(articleListView.articleItemList.count, 0)
    }
    
    func testServiceManagerInvalidURL(){
        let exp = expectation(description: "Receive request failure error for invalid URL")
        var result: APIError?
        let restServicemanager: DataRequestProtocol = RESTServiceManager()
        restServicemanager.sendDataRequest(requestObject: RequestObj(apiManager: .getResponseFromInvalidUrl), completion: { (response: Result<Root, APIError>) in
            switch response {
            case .success(_):
                XCTAssert(false, "An unexpected result encountered. Received success for invalid URL")
            case .failure(let error):
                result = error
                exp.fulfill()
            }
        })
        wait(for: [exp], timeout: 2)
        XCTAssertNotNil(result)
        XCTAssertTrue(result == .requestFailure, "An expected result encountered. Failure for invalid URL")
    }
    
    func testServiceManagerValidURL(){
        let exp = expectation(description: "Receive articles response from valid URL")
        var result: Root?
        let restServicemanager: DataRequestProtocol = RESTServiceManager()
        restServicemanager.sendDataRequest(requestObject: RequestObj(apiManager: .getArticleList), completion: { (response: Result<Root, APIError>) in
            switch response {
            case .success(let root):
                result = root
                exp.fulfill()
            case .failure(_):
                XCTAssert(false, "An unexpected result encountered.")
            }
        })
        wait(for: [exp], timeout: 3)
        XCTAssertNotNil(result)
        XCTAssertTrue(result?.articles.count ?? 0 > 0,"Articles received")
    }
    
    func testArrayAccessSafety() throws{
        let mockArray = Array.init(repeating: "Test", count: 4)
        XCTAssertNotNil(mockArray[safeIndex: 3])
        XCTAssertNil(mockArray[safeIndex: 8])
    }
    
    override func tearDownWithError() throws {
        testSut = nil
        articleListView = nil
    }
}
