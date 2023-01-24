//
//  ViewControllerTests.swift
//  NewsArticlesTests
//
//  Created by Aks_dev on 04/11/22.
//

import XCTest
@testable import NewsArticles

final class ViewControllerTests: XCTestCase {

    private var articleDetailView: ArticleDetailsViewController!
    private var articleListViewController: ArticleListViewController!
    private var articles: [Article] = Array.init(repeating: Article(title: "Title", urlToImage: "url", content: "content", description: "desciption", source: nil), count: 3)

    override func setUpWithError() throws {
    guard let vc = UtilsUIKit.getViewControllerWith(storyBoardName: .main, viewControllerId: .articleListController) as? ArticleListViewController else {
            return XCTFail("Failed to instantiate ViewController from storyboard")
        }
        articleListViewController = vc
        articleListViewController.articleItemList = articles
        articleListViewController.loadViewIfNeeded()
    }

    func testControllerHasTableView() {
        XCTAssertNotNil(articleListViewController.articleListTableView,
                        "Controller must have a tableview")
    }

    func testLoadDetailedView() throws {
    guard let articleDetailsViewController = UtilsUIKit.getViewControllerWith(storyBoardName: .main, viewControllerId: .articleDetailsController) as? ArticleDetailsViewController else {
            return XCTFail("Failed to instantiate ViewController from storyboard")
        }
        articleDetailsViewController.articleDetailsViewModel.article = Article(title: "title", urlToImage: "", content: "", description: "", source: nil)
        articleDetailsViewController.loadViewIfNeeded()
        XCTAssertEqual(articleDetailsViewController.articleDetailsViewModel.article?.title, "title")
    }

    func testJailBrokenView() throws {
    guard let jailBrokenDeviceDetectedViewController = UtilsUIKit.getViewControllerWith(storyBoardName: .main, viewControllerId: .jailBrokenViewController) as? JailBrokenDeviceDetectedViewController else {
            return XCTFail("Failed to instantiate ViewController from storyboard")
        }
        jailBrokenDeviceDetectedViewController.loadViewIfNeeded()
        XCTAssertNotNil(jailBrokenDeviceDetectedViewController)
    }

    
    func testrealTableViewHasCells() {
        let cell = articleListViewController.articleListTableView.dequeueReusableCell(withIdentifier: StoryBoards.CellIdentifier.articleItemCell.rawValue) as! ArticleItemCell
        XCTAssertNotNil(cell)
        cell.articleItemCellViewModel = ArticleItemCellViewModel(article: articles[0])
        cell.inflactWithData()
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
