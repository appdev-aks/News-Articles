//
//  UtilsUIKit.swift
//  NewsArticles
//
//  Created by Akshay Pure on 04/11/22.
//

import Foundation
import UIKit

extension UITableViewCell {
    static func registerWith(tableView: UITableView) {
        tableView.register(UINib(nibName: String(describing: self), bundle: Bundle(for: self)), forCellReuseIdentifier: String(describing: self))
    }
}

