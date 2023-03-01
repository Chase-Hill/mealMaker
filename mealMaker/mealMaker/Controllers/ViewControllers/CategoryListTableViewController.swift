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
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        let category = categoryArray[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = category.categoryName
        cell.contentConfiguration = config

        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
