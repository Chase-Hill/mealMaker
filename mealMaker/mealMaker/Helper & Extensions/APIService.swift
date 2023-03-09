//
//  APIService.swift
//  mealMaker
//
//  Created by Chase on 3/9/23.
//

import Foundation

struct APIService {
    
    func perform(_ request: URLRequest, mealsLoaded: @escaping (Result <Data, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                mealsLoaded(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                print("\(response.statusCode)")
            }
            guard let data = data else {
                mealsLoaded(.failure(.noData))
                return
            }
            mealsLoaded(.success(data))
        } .resume()
    }
}
