//
//  ViewController.swift
//  News Articles
//
//  Created by Aks_dev on 03/11/22.
//

import UIKit

protocol ViewDataSource {
    func articlesReceived(characterList: [Article])
}

class ArticleListViewController: UIViewController {

    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var articleListTableView: UITableView!
    var articleItemList: [Article] = []
    
    lazy var viewModel: ArticleDataProtocol = {
        ArticleListViewModel.init(viewDataSource: self, articleRepositoryProtocol: ArticleRepository())
    }() as ArticleDataProtocol
    
    var isLoading = false {
        didSet {
            isLoading ? loadingActivityIndicator.startAnimating() : loadingActivityIndicator.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingActivityIndicator.hidesWhenStopped = true
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
        viewModel.requestArticles()
    }
}

extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articleItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
}

extension ArticleListViewController: ViewDataSource {
    func articlesReceived(characterList: [Article]) {
        
    }
}
