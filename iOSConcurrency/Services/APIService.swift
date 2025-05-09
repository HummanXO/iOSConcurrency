//
//  APIService.swift
//  iOSConcurrency
//
//  Created by Aleksandr on 09.05.2025.
//

import Foundation

struct APIService {
    
    let urlSting: String
    
    func fetchJSON<T: Decodable>(dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                 keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
                                 completion: @escaping (Result<T, APIError>) -> Void) {
        guard
            let url = URL(string: urlSting)
        else {
            completion(.failure(.invalideURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else {
                completion(.failure(.invalideResponse))
                return
            }
            
            guard
                error == nil
            else {
                completion(.failure(.errorDataTask))
                return
            }
            
            guard
                let data = data
            else {
                completion(.failure(.errorFetchData))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            }
            catch {
                completion(.failure(.errorDecode))
            }
            
        }
        .resume()
    }
    
}

enum APIError: Error {
    case invalideURL
    case invalideResponse
    case errorDataTask
    case errorFetchData
    case errorDecode
}
