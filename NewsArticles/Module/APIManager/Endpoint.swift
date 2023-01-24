//
//  Endpoint.swift
//  NewsArticles
//
//  Created by Akshay Pure on 24/01/23.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Endpoint {
    var httpMethod: HTTPMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: Any]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    var url: String {
        return baseURL + path
    }
}
