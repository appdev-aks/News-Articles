//
//  Utils.swift
//  NewsArticles
//
//  Created by Aks_dev on 04/11/22.
//

import Foundation

struct Utils {
    static func decodeWith<T: Decodable>(from data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}
