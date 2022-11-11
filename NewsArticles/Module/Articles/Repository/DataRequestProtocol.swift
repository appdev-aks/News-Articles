//
//  DataRequestProtocol.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

protocol DataRequestProtocol {
    func sendDataRequest<T: Decodable>(requestObject: RequestObj, completion: @escaping ((Result<T, APIError>) -> Void))
}
