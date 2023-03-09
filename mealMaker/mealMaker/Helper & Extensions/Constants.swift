//
//  Constants.swift
//  mealMaker
//
//  Created by Chase on 3/1/23.
//

import Foundation

struct Constants {
    
    struct MealService {
        static let allCategoriesBaseURL = "https://www.themealdb.com/api/json/v1/1/categories.php"
        static let mealsInCategoryBaseURL = "https://www.themealdb.com/api/json/v1/1/filter.php"
        static let categoryQueryKey = "c"
        static let recipeBaseURL = "https://www.themealdb.com/api/json/v1/1/lookup.php"
        static let recipeQueryKey = "i"
        
    }
}
