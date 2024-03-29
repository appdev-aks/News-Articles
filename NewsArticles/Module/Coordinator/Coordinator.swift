//
//  Coordinator.swift
//  NewsArticles
//
//  Created by Aks_dev on 14/11/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
    func showJailBrokenScreen()
    //We can create child coordinators and segregate other navigations accordingly.
    func launchArticleDetailsView(with article: Article)
}
