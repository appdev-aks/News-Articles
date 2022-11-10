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
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var articleImageView: UIImageView!

    func inflactWith(article: Article) {
        titleLabel.text = article.title
        sourceLabel.text = article.source?.name ?? ""
        ImageLoader.loadImage(url: article.urlToImage ?? "", imageView: articleImageView)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
