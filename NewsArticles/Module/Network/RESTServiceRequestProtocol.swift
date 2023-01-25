//
//  RESTServiceRequestProtocol.swift
//  NewsArticles
//
//  Created by Akshay Pure on 25/01/23.
//

import Foundation

protocol RESTServiceRequestProtocol {
    func getRequest(using requestObject: RequestObj, url: URL) -> URLRequest
    func postRequest(using requestObject: RequestObj, url: URL) -> URLRequest
    func executeDataTask(urlRequest: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void)
}
