//
//  DataRequestProtocol.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

protocol DataRequestProtocol {
    func sendDataRequest(requestObject: RequestObj, completion: @escaping ((Result<Data, APIError>) -> Void))
}
