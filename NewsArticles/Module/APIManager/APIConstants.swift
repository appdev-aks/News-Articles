//
//  APIConstants.swift
//  NewsArticles
//
//  Created by Akshay Pure on 24/01/23.
//

import Foundation

struct APIConstants {
    static let countryCode = "us"
    #warning("Ideally the config file should be added to gitignore file and not committed. For demo app its committed.")
    static let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
}
