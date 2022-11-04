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
        articleListView.loadViewIfNeeded()
        let mockRepo = MockArticleRepository(apiManager: .getArticleList)
        articleListView.viewModel = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: mockRepo)
        articleListView.viewModel.requestArticles()
        XCTAssertEqual(articleListView.articleItemList.count, 7)
    }
    
    func testEmptyArticleDataResponse() throws {
        articleListView.loadViewIfNeeded()
        let mockRepo = MockArticleRepository(apiManager: .getEmptyMockArticleList)
        articleListView.viewModel = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: mockRepo)
        articleListView.viewModel.requestArticles()
        XCTAssertEqual(articleListView.articleItemList.count, 0)
    }

    func testInvalidArticleDataResponse() throws {
        articleListView.loadViewIfNeeded()
        let mockRepo = MockArticleRepository(apiManager: .getMockInvalidResponse)
        articleListView.viewModel = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: mockRepo)
        
        articleListView.viewModel.requestArticles()
        XCTAssertNotNil(mockRepo.mockError)
        XCTAssertEqual(articleListView.articleItemList.count, 0)
    }
    
    func testNilArticleDataResponse() throws {
        articleListView.loadViewIfNeeded()
        let mockRepo = MockArticleRepository(apiManager: .getNilResponse)
        articleListView.viewModel = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: mockRepo)
        
        articleListView.viewModel.requestArticles()
        XCTAssertNotNil(mockRepo.mockError)
        XCTAssertEqual(articleListView.articleItemList.count, 0)
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
