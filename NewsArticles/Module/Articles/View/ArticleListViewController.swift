//
//  ViewController.swift
//  News Articles
//
//  Created by Aks_dev on 03/11/22.
//

import UIKit

class ArticleListViewController: UIViewController {

    @IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var articleListTableView: UITableView!
    var articleItemList: [Article] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingActivityIndicator.hidesWhenStopped = true
        articleListTableView.delegate = self
        articleListTableView.dataSource = self
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
