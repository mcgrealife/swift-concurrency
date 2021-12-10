//
//  APIService.swift
//  concurrency
//
//  Created by Michael McGreal on 12/9/21.
//

import Foundation

struct APIService {
    let urlString: String
    
    func getJSON<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys, completion: @escaping (Result<T,Error>) -> Void) {
        guard
            let url = URL(string: urlString)
        else {
            completion(.failure(APIError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                completion(.failure(APIError.invalidResponseStatus))
                return
            }
            guard
                error == nil
            else {
                completion(.failure(APIError.dataTaskError))
                return
            }
            guard
                let data = data
            else {
                completion(.failure(APIError.corruptData))
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            do {
                let decodedData = try decoder.decode(T.self , from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(APIError.decodingError))
            }
            
        }.resume()
    }
}


enum APIError: Error {
    case invalidURL
    case invalidResponseStatus
    case dataTaskError
    case corruptData
    case decodingError
}
