//
//  MealService.swift
//  mealMaker
//
//  Created by Chase on 3/1/23.
//

import UIKit

protocol MealServiceable {
    func fetchAllCategories(completion: @escaping (Result<[Category], NetworkError>) -> Void)
    func fetchMealsInCategory(forCategory category: Category, completion: @escaping (Result<[Meal], NetworkError>) -> Void)
    func fetchRecipe(forMeal meal: Meal, completion: @escaping (Result<Recipe, NetworkError>) -> Void)
    func fetchImage(for item: String?, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

struct MealService: MealServiceable {
    
    // MARK: - Properties
    let service = APIService()
    
    // MARK: - Functions
    func fetchAllCategories(completion: @escaping (Result<[Category], NetworkError>) -> Void) {
        
        guard let finalURL = URL(string: Constants.MealService.allCategoriesBaseURL) else { completion(.failure(.invalidURL)) ; return }
        print("Categories URL: \(finalURL)")
        
        let request = URLRequest(url: finalURL)
        service.perform(request) { result in
            switch result {
            case .success(let data):
                
                do {
                    let topLevel = try JSONDecoder().decode(CategoryTopLevelDictionary.self, from: data)
                    completion(.success(topLevel.categories))
                } catch {
                    completion(.failure(.unableToDecode)) ; return
                }
            case .failure( let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
    
    func fetchMealsInCategory(forCategory category: Category, completion: @escaping (Result<[Meal], NetworkError>) -> Void) {
        
        guard let baseURL = URL(string: Constants.MealService.mealsInCategoryBaseURL) else { completion(.failure(.invalidURL)) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let categoryQueryItem = URLQueryItem(name: Constants.MealService.categoryQueryKey, value: category.categoryName)
        urlComponents?.queryItems = [categoryQueryItem]
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("Meals URL: \(finalURL)")
        
        let request = URLRequest(url: finalURL)
        service.perform(request) { result in
            switch result {
            case .success(let data):
                do {
                    let topLevel = try JSONDecoder().decode(MealTopLevelDictionary.self, from: data)
                    completion(.success(topLevel.meals))
                } catch {
                    completion(.failure(.unableToDecode)) ; return
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
    
    func fetchRecipe(forMeal meal: Meal, completion: @escaping (Result<Recipe, NetworkError>) -> Void) {
        
        guard let baseURL = URL(string: Constants.MealService.recipeBaseURL) else { completion(.failure(.invalidURL)) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let recipeQueryItem = URLQueryItem(name: Constants.MealService.recipeQueryKey, value: meal.mealID)
        urlComponents?.queryItems = [recipeQueryItem]
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("Recipe URL: \(finalURL)")
        
        let request = URLRequest(url: finalURL)
        service.perform(request) { result in
            switch result {
            case .success(let data):
                do {
                    let topLevel = try JSONDecoder().decode(RecipeTopLevelDictionary.self, from: data)
                    if let recipe = topLevel.meals.first {
                        completion(.success(recipe))
                    } else {
                        completion(.failure(.unableToDecode)) ; return
                    }
                } catch {
                    completion(.failure(.unableToDecode)) ; return
                }
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
    
    func fetchImage(for item: String?, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        
        guard let item = item else { completion(.success(UIImage(named: "Samurai")!)) ; return }
        
        guard let finalURL = URL(string: item) else { completion(.failure(.invalidURL)) ; return }
        print("Final Image URL: \(finalURL)")
        
        let request = URLRequest(url: finalURL)
        service.perform(request) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { completion(.failure(.unableToDecode)) ; return }
                completion(.success(image))
            case .failure(let error):
                completion(.failure(.thrownError(error)))
            }
        }
    }
}
