//
//  MealService.swift
//  mealMaker
//
//  Created by Chase on 3/1/23.
//

import Foundation

struct MealService {
    
    static func fetchAllCategories(completion: @escaping (Result<[Category], NetworkError>) -> Void) {
        
        guard let finalURL = URL(string: Constants.MealService.allCategoriesBaseURL) else { completion(.failure(.invalidURL)) ; return }
        print("Categories URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error))) ; return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Categories Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            
            do {
                
                let topLevel = try JSONDecoder().decode(CategoryTopLevelDictionary.self, from: data)
                completion(.success(topLevel.categories))
            } catch {
                
                print("There was an error decoding the category data: \(error.localizedDescription)")
                completion(.failure(.unableToDecode)) ; return
            }
        } .resume()
    }
    
    static func fetchMealsInCategory(forCategory category: Category, completion: @escaping (Result<[Meal], NetworkError>) -> Void) {
        
        guard let baseURL = URL(string: Constants.MealService.mealsInCategoryBaseURL) else { completion(.failure(.invalidURL)) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let categoryQueryItem = URLQueryItem(name: Constants.MealService.categoryQueryKey, value: category.categoryName)
        urlComponents?.queryItems = [categoryQueryItem]
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("Meals URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error))) ; return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Meals Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            
            do {
                
                let topLevel = try JSONDecoder().decode(MealTopLevelDictionary.self, from: data)
                completion(.success(topLevel.meals))
            } catch {
                
                print("There was an error decoding the meal data: \(error.localizedDescription)")
                completion(.failure(.unableToDecode)) ; return
            }
        } .resume()
    }
}
