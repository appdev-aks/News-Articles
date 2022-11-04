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

    
    override func setUpWithError() throws {
        guard let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ArticleListViewController") as? ArticleListViewController else {
            return XCTFail("Could not instantiate ViewController from main storyboard")
        }
        articleListViewController = vc
    }
    
    func testControllerHasTableView() {
        articleListViewController.loadViewIfNeeded()
        XCTAssertNotNil(articleListViewController.articleListTableView,
                        "Controller should have a tableview")
    }

    override func tearDownWithError() throws {
        articleListViewController = nil
    }

}
