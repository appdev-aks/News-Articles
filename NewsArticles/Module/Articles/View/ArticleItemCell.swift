//
//  ArticleItemCell.swift
//  NewsArticles
//
//  Created by Akshay Pure on 04/11/22.
//

import Foundation
import UIKit

class ArticleItemCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!

    func inflactWith(article: Article){
        titleLabel.text = article.title
        sourceLabel.text = article.source?.name ?? ""
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
