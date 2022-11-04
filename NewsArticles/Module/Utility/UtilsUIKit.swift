//
//  UtilsUIKit.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation
import UIKit

extension UITableViewCell {
    static func registerWith(tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: self), bundle: Bundle(for: self)), forCellReuseIdentifier: String(describing: self))
    }
}

class UtilsUIKit {
    static func getViewControllerWith(storyBoardName: StoryBoards.StoryboardNames, viewControllerId: StoryBoards.ViewControllerIdentifier) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyBoardName.rawValue, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId.rawValue)
        return viewController
    }
}
