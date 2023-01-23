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
        let storyboard = UIStoryboard(name: StoryBoards.StoryboardNames.main.rawValue, bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: StoryBoards.ViewControllerIdentifier.articleListController.rawValue) as? ArticleListViewController {
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: false)
        }
    }
    
    func showJailBrokenScreen() {
        let storyboard = UIStoryboard(name: StoryBoards.StoryboardNames.main.rawValue, bundle: Bundle.main)
        if let vc = storyboard.instantiateViewController(withIdentifier: StoryBoards.ViewControllerIdentifier.jailBrokenViewController.rawValue) as? JailBrokenDeviceDetectedViewController {
            vc.coordinator = self
            navigationController.pushViewController(vc, animated: false)
        }
    }
    
    func launchArticleDetailsView(with article: Article) {
        if let articleDetailsController = UtilsUIKit.getViewControllerWith(storyBoardName: .main, viewControllerId: .articleDetailsController) as? ArticleDetailsViewController {
            articleDetailsController.articleDetailsViewModel.article = article
            navigationController.present(articleDetailsController, animated: true, completion: nil)
        }
    }
}
