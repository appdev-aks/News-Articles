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
        testSut = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: MockArticleRepository())
    }
                                       
    func testArticleDataFlowForRequestAndResponse() throws {
        articleListView.loadViewIfNeeded()
        articleListView.viewModel = ArticleListViewModel(viewDataSource: articleListView, articleRepositoryProtocol: MockArticleRepository())
        articleListView.viewModel.requestArticles()
        XCTAssertEqual(articleListView.articleItemList.count, 5)
    }
    

    override func tearDownWithError() throws {
        testSut = nil
        articleListView = nil
    }
}
