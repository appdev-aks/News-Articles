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
        guard let controller = UtilsUIKit.getViewControllerWith(storyBoardName: .main, viewControllerId: .articleListController) as? ArticleListViewController else {
            return XCTFail("Failed to instantiate ViewController from main storyboard")
        }
        articleListView = controller
        testSut = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: MockArticleRepository(apiManager: .getArticleList(countryCode: "us", apiKey: "apikeygfgdfvcxdsg")))
    }
                                       
    func testArticleDataFlowForRequestAndResponse() throws {
        let exp = expectation(description: "Get articles from response")
        articleListView.loadViewIfNeeded()
        let mockRepo = MockArticleRepository(apiManager: .getArticleList(countryCode: "us", apiKey: "apikeygfgdfvcxdsg"))
        articleListView.viewModel = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: mockRepo)
        articleListView.viewModel.requestArticles()
        exp.fulfill()
        waitForExpectations(timeout: 1)
        XCTAssertEqual(articleListView.articleItemList.count, 7, "Expected number of articles received")
    }
    
    func testEmptyArticleDataResponse() throws {
        let exp = expectation(description: "Get zero articles if array is empty")
        articleListView.loadViewIfNeeded()
        let mockRepo = MockArticleRepository(apiManager: .getEmptyArticleList)
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
        let mockRepo = MockArticleRepository(apiManager: .getInvalidResponseData)
        articleListView.viewModel = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: mockRepo)
        
        articleListView.viewModel.requestArticles()
        exp.fulfill()
        waitForExpectations(timeout: 1)
        XCTAssertEqual(articleListView.errorMessage, APIError.responseDataError.getErrorMessage())
        XCTAssertNotNil(mockRepo.mockError)
        XCTAssertEqual(articleListView.articleItemList.count, 0)
    }
    
    func testStubDataWhenRequestFailed(){
        articleListView.loadViewIfNeeded()
        let repo = ArticleRepository()
        articleListView.viewModel = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: repo)
        articleListView.viewModel.requestArticlesFromStub()
        XCTAssertEqual(articleListView.articleItemList.count, 7, "Expected number of articles received")
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
        restServicemanager.sendDataRequest(requestObject: RequestObj(apiManager: .getResponseFromInvalidUrl), completion: { (response: Result<Data, APIError>) in
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
        if NetworkMonitor.shared.isConnected {
            XCTAssertTrue(result == .requestFailure, "An expected result encountered. Failure for invalid URL")
        } else {
            XCTAssertTrue(result == .networkConnectionFailed, "An expected result encountered. Failure no internet")
        }
    }
    
    func testDecoder(){
        let response = ArticleDataResources.getFileContents(fileName: ArticleResponseFiles.articlesResponse)
        if let response = response {
            do {
                let result: ArticleResponse = try Utils.decodeWith(from: Data(response.utf8))
                XCTAssertTrue(result.articles.count > 0)
            } catch {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testJailBrokenDeviceCondition(){
        XCTAssertFalse(JailBrokenHelper.hasCydiaInstalled())
        XCTAssertFalse(JailBrokenHelper.canEditSystemFiles())
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
