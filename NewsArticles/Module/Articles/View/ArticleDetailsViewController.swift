//
//  ArticleDetailsViewController.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation
import UIKit

class ArticleDetailsViewController: UIViewController {
    
    let articleDetailsViewModel = ArticleDetailsViewModel()
    
    @IBOutlet private weak var imageArticle: UIImageView!
    @IBOutlet private weak var labelTitle: UILabel!
    @IBOutlet private weak var labelDescription: UILabel!
    @IBOutlet private weak var labelDate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let article = articleDetailsViewModel.article {
            labelTitle.text = article.title
            labelDescription.text = article.description
            labelDate.text = article.source?.name
            if let articleURL = article.urlToImage {
                ImageLoader.loadImage(url: articleURL, imageView: imageArticle)
            }
        }
    }
}
