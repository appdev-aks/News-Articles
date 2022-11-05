//
//  ViewController.swift
//  News Articles
//
//  Created by Aks_dev on 03/11/22.
//

import UIKit

protocol ViewDataSource {
    func articlesReceived(articleList: [Article])
    func showViewForFailedArticleRequest()
}

class ArticleListViewController: UIViewController {

    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var articleListTableView: UITableView!
    @IBOutlet weak var retryView: UIView!
    var articleItemList: [Article] = []
    
    lazy var viewModel: ArticleDataProtocol = {
        ArticleListViewModel.init(viewDataSource: self, articleRepositoryProtocol: ArticleRepository())
    }() as ArticleDataProtocol
    
    var isLoading = false {
        didSet {
            isLoading ? loadingActivityIndicator.startAnimating() : loadingActivityIndicator.stopAnimating()
        }
    }
    
    var dataFetched = false {
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
        if let articleDetailsController = UtilsUIKit.getViewControllerWith(storyBoardName: .main, viewControllerId: .articleDetailsController) as? ArticleDetailsViewController{
            articleDetailsController.article = articleItemList[safeIndex: indexPath.row]
            self.present(articleDetailsController, animated:true, completion:nil)
        }
    }
}

extension ArticleListViewController: ViewDataSource {
    func showViewForFailedArticleRequest() {
        DispatchQueue.main.async {
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
