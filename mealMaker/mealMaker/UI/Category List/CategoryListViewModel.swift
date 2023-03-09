//
//  MealViewModel.swift
//  mealMaker
//
//  Created by Chase on 3/9/23.
//

import Foundation

protocol CategoryListViewModelDelegate: AnyObject {
    func categoriesFetchedSuccessfully()
}

class CategoryListViewModel {
    
    // MARK: - Properties
    private weak var delegate: CategoryListViewModelDelegate?
    let mealService: MealServiceable
    var categories: [Category] = []
    
    init(delegate: CategoryListViewModelDelegate, serviceInjected: MealServiceable = MealService()) {
        self.delegate = delegate
        self.mealService = serviceInjected
        self.fetchData()
    }
    
    // MARK: - Functions
    func fetchData() {
        mealService.fetchAllCategories { result in
            switch result {
            case .success(let categories):
                    self.categories = categories
                    self.delegate?.categoriesFetchedSuccessfully()
            case .failure(let error):
                print(error.errorDescription ?? NetworkError.unknownError)
            }
        }
    }
}
