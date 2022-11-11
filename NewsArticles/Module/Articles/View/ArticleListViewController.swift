//
//  ViewController.swift
//  News Articles
//
//  Created by Aks_dev on 03/11/22.
//

import UIKit

protocol ViewDataSource {
    func articlesReceived(articleList: [Article])
    func showViewForFailedArticleRequest(error: APIError)
}

class ArticleListViewController: UIViewController {

    @IBOutlet private weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var articleListTableView: UITableView!
    @IBOutlet private weak var retryView: UIStackView!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    var articleItemList: [Article] = []
    var errorMessage: String = ""

    lazy var viewModel: ArticleDataProtocol = {
        ArticleListViewModel.init(viewDataSource: self, articleRepositoryProtocol: ArticleRepository())
    }() as ArticleDataProtocol
    
    private var isLoading = false {
        didSet {
            isLoading ? loadingActivityIndicator.startAnimating() : loadingActivityIndicator.stopAnimating()
        }
    }
    
    private var dataFetched = false {
        didSet {
             retryView.isHidden = dataFetched
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingActivityIndicator.hidesWhenStopped = true
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
        title = NSLocalizedString("ArticleListTitle", comment: "Title for article list")
        ArticleItemCell.registerWith(tableView: articleListTableView)
        requestArticleData()
    }
    
    @IBAction func reloadArticles(_ sender: Any) {
        requestArticleData()
    }
    
    fileprivate func requestArticleData() {
        self.viewModel.requestArticles()
    }
}

extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articleItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoards.CellIdentifier.articleItemCell.rawValue) as? ArticleItemCell {
            cell.inflactWith(article: articleItemList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let articleDetailsController = UtilsUIKit.getViewControllerWith(storyBoardName: .main, viewControllerId: .articleDetailsController) as? ArticleDetailsViewController {
            articleDetailsController.article = articleItemList[safeIndex: indexPath.row]
            self.present(articleDetailsController, animated: true, completion: nil)
        }
    }
}

extension ArticleListViewController: ViewDataSource {
    func showViewForFailedArticleRequest(error: APIError) {
        errorMessage = error.getErrorMessage()
        DispatchQueue.main.async {
            self.errorMessageLabel.text = self.errorMessage
            self.isLoading = false
            self.dataFetched = false
        }
        debugPrint("Show failed request view")
    }
    
    func articlesReceived(articleList: [Article]) {
        self.articleItemList = articleList
        DispatchQueue.main.async {
            self.articleListTableView.reloadData()
            self.isLoading = false
            self.dataFetched = true
        }
    }
}
