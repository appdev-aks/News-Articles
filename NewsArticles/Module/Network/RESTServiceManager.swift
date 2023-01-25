//
//  APIManager.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

class RESTServiceManager {
    fileprivate func fetchDataUsing(requestObject: RequestObj, completion: @escaping  (Result<Data, APIError>) -> Void) {

        guard NetworkMonitor.shared.isConnected else {
            completion(.failure(APIError.networkConnectionFailed))
            return
        }
        
        guard let url = URL(string: requestObject.apiManager.url) else {
            completion(.failure(APIError.requestFailure))
            return
        }

        switch requestObject.apiManager.httpMethod {
        case .post:
            let urlRequest = postRequest(using: requestObject, url: url)
            executeDataTask(urlRequest: urlRequest, completion: completion)
        case .get:
            let urlRequest = getRequest(using: requestObject, url: url)
            executeDataTask(urlRequest: urlRequest, completion: completion)
        }
    }
}

extension RESTServiceManager: DataRequestProtocol {
    func sendDataRequest(requestObject: RequestObj, completion: @escaping ((Result<Data, APIError>) -> Void)) {
        fetchDataUsing(requestObject: requestObject, completion: completion)
    }
}

extension RESTServiceManager: RESTServiceRequestProtocol {
    func getRequest(using requestObject: RequestObj, url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        requestObject.apiManager.headers?.forEach({ header in
            urlRequest.setValue(header.value as? String, forHTTPHeaderField: header.key)
        })
        return urlRequest
    }
    
    func postRequest(using requestObject: RequestObj, url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.httpBody = requestObject.apiManager.body?.data(using: .utf8)
        requestObject.apiManager.headers?.forEach({ header in
            urlRequest.setValue(header.value as? String, forHTTPHeaderField: header.key)
        })
        return urlRequest
    }
    
    func executeDataTask(urlRequest: URLRequest, completion: @escaping (Result<Data, APIError>) -> Void) {
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { responseData, _, error in
            if let responseData = responseData {
                completion(.success(responseData))
            } else {
                debugPrint(error.debugDescription)
                completion(.failure(APIError.responseDataError))
            }
        }
        urlSession.resume()
    }
}
