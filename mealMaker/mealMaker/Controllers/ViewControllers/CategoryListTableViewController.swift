//
//  CategoryListTableViewController.swift
//  mealMaker
//
//  Created by Chase on 3/1/23.
//

import UIKit

class CategoryListTableViewController: UITableViewController {
    
    // MARK: - LifeCyle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllCategories()
    }

    // MARK: - Properties
    var categoryArray: [Category] = []
    
    // MARK: - Functions
    func fetchAllCategories() {
        MealService.fetchAllCategories { [weak self] result in
            switch result {
            case .success(let categories):
                self?.categoryArray = categories
                DispatchQueue.main.async { self?.tableView.reloadData() }
                
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }
    
    func configCell(cell: UITableViewCell, category: Category) {
        var config = cell.defaultContentConfiguration()
        
        config.text = category.categoryName
        config.secondaryText = category.description
        cell.contentConfiguration = config
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        let category = categoryArray[indexPath.row]
        configCell(cell: cell, category: category)

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMealListVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? MealListTableViewController else { return }
            let category = categoryArray[indexPath.row]
            destinationVC.category = category
        }
    }
}
