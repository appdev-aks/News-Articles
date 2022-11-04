//
//  ImageLoader.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation
import Nuke
import UIKit

class ImageLoader {
    static func loadImage(url: String, imageView: UIImageView) {
        if let url = URL(string: url) {
            Nuke.loadImage(with: url, into: imageView)
        }
    }
}
