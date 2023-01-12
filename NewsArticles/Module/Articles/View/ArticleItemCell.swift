//
//  ArticleItemCell.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation
import UIKit
import Nuke

class ArticleItemCell: UITableViewCell {
    
    var articleItemCellViewModel: ArticleItemCellViewModel?
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var articleImageView: UIImageView!

    func inflactWithData() {
        titleLabel.text = self.articleItemCellViewModel?.article.title
        sourceLabel.text = articleItemCellViewModel?.article.source?.name ?? ""
        if let articleURL = articleItemCellViewModel?.article.urlToImage {
            ImageLoader.loadImage(url: articleURL, imageView: articleImageView)
        }
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
        articleImageView.image = nil
    }
}
