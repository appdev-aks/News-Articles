//
//  ArticleCoordinator.swift
//  NewsArticles
//
//  Created by Aks_dev on 14/11/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if let articleListViewController = UtilsUIKit.getViewControllerWith(storyBoardName: .main, viewControllerId: .articleListController) as? ArticleListViewController {
            articleListViewController.coordinator = self
            navigationController.pushViewController(articleListViewController, animated: false)
        }
    }
    
    func showJailBrokenScreen() {
        if let jailBrokenDeviceViewController = UtilsUIKit.getViewControllerWith(storyBoardName: .main, viewControllerId: .jailBrokenViewController) as? JailBrokenDeviceDetectedViewController {
            jailBrokenDeviceViewController.coordinator = self
            navigationController.pushViewController(jailBrokenDeviceViewController, animated: false)
        }
    }
    
    func launchArticleDetailsView(with article: Article) {
        if let articleDetailsController = UtilsUIKit.getViewControllerWith(storyBoardName: .main, viewControllerId: .articleDetailsController) as? ArticleDetailsViewController {
            articleDetailsController.articleDetailsViewModel.article = article
            navigationController.present(articleDetailsController, animated: true, completion: nil)
        }
    }
}
