//
//  APIManager.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

class RESTServiceManager {
    func fetchDataUsing<T: Decodable>(requestObject: RequestObj, completion: @escaping  (Result<T, APIError>) -> Void) {

        guard NetworkMonitor.shared.isConnected else {
            completion(.failure(APIError.networkConnectionFailed))
            return
        }
        
        guard let url = URL(string: requestObject.apiManager.url) else {
            completion(.failure(APIError.requestFailure))
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestObject.apiManager.httpMethod.rawValue
        
        requestObject.apiManager.headers?.forEach({ header in
            urlRequest.setValue(header.value as? String, forHTTPHeaderField: header.key)
        })
        
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { responseData, _, error in
            
            if let responseData {
                do {
                    let result: T = try Utils.decodeWith(from: responseData)
                    completion(.success(result))
                } catch let error {
                    debugPrint(error.localizedDescription)
                    completion(.failure(APIError.responseDataError))
                }
            } else {
                completion(.failure(APIError.responseDataError))
            }
        }
        urlSession.resume()
    }
}

extension RESTServiceManager: DataRequestProtocol {
    func sendDataRequest<T>(requestObject: RequestObj, completion: @escaping ((Result<T, APIError>) -> Void)) where T: Decodable {
        fetchDataUsing(requestObject: requestObject, completion: completion)
    }
}
