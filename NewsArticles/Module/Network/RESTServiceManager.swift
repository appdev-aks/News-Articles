//
//  APIManager.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

class RESTServiceManager {
    func fetchDataUsing<T: Decodable>(requestObject: RequestObj, completion: @escaping  (Result<T, APIError>) -> Void) {
        if NetworkMonitor.shared.isConnected {
            if let url = requestObject.apiManager.getURL() {
                let urlSession = URLSession.shared.dataTask(with: url) { responseData, _, error in
                    
                    if let response = responseData {
                        let decoder = JSONDecoder()
                        do {
                            let result = try decoder.decode(T.self, from: response)
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
            } else {
                completion(.failure(APIError.requestFailure))
            }
        } else {
            completion(.failure(.networkConnectionFailed))
        }
    }
}

extension RESTServiceManager: DataRequestProtocol {
    func sendDataRequest<T>(requestObject: RequestObj, completion: @escaping ((Result<T, APIError>) -> Void)) where T: Decodable {
        fetchDataUsing(requestObject: requestObject, completion: completion)
    }
}
