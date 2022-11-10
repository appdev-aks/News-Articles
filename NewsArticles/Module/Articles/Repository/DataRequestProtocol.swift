//
//  DataRequestProtocol.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

protocol DataRequestProtocol {
    func sendDataRequest<T: Decodable>(requestObject: RequestObj, callback: @escaping ((Result<T, Error>) -> Void))
}
