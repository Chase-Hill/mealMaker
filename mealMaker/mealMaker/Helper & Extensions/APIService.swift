//
//  APIService.swift
//  mealMaker
//
//  Created by Chase on 3/9/23.
//

import Foundation

struct APIService {
    
    func perform(_ request: URLRequest, moviesLoaded: @escaping (Result <Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                moviesLoaded(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("\(response.statusCode)")
            }
            guard let data = data else {
                moviesLoaded(.failure(.noData))
                return
            }
            moviesLoaded(.success(data))
        } .resume()
    }
}
