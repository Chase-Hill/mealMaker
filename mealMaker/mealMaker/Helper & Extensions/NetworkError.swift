//
//  NetworkError.swift
//  mealMaker
//
//  Created by Chase on 3/1/23.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL. Check URL endpoint"
        case .thrownError(let error):
            return "Thrown Error: \(error.localizedDescription)"
        case .noData:
            return "No data received from network fetch."
        case .unableToDecode:
            return "Unable to decode the data from network."
        }
    }
}