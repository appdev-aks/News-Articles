//
//  ViewControllerTests.swift
//  NewsArticlesTests
//
//  Created by Aks_dev on 04/11/22.
//

import XCTest
@testable import NewsArticles

final class ViewControllerTests: XCTestCase {

    var articleListViewController: ArticleListViewController!
    var articles: [Article] = Array.init(repeating: Article(title: "Title", urlToImage: "url", content: "content", description: "desciption", source: nil), count: 3)
    
    override func setUpWithError() throws {
        guard let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ArticleListViewController") as? ArticleListViewController else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        articleListViewController = vc
        articleListViewController.articleItemList = articles
        articleListViewController.loadViewIfNeeded()
    }
    
    func testControllerHasTableView() {
        XCTAssertNotNil(articleListViewController.articleListTableView,
                        "Controller should have a tableview")
    }
    
    func testrealTableViewHasCells() {
        let cell = articleListViewController.articleListTableView.dequeueReusableCell(withIdentifier: StoryBoards.CellIdentifier.articleItemCell.rawValue) as! ArticleItemCell
        XCTAssertNotNil(cell)
        cell.inflactWith(article: articles[0])
        articleListViewController.viewModel.populateArticleData(articles: articles)
        XCTAssertEqual(articleListViewController.articleListTableView.numberOfRows(inSection: 0), 3)
    }
    
    func testTableViewHasCells() {
        let cell = articleListViewController.articleListTableView.dequeueReusableCell(withIdentifier: StoryBoards.CellIdentifier.articleItemCell.rawValue)
        XCTAssertNotNil(cell,
                        "TableView should have cell with identifier: 'ArticleItemCell'")
    }

    override func tearDownWithError() throws {
        articleListViewController = nil
    }

}
