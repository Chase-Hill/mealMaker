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
        viewModel = CategoryListViewModel(delegate: self)
    }
    
    // MARK: - Properties
    var viewModel: CategoryListViewModel!
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        let category = viewModel.categories[indexPath.row]
        var config = cell.defaultContentConfiguration()
        
        config.text = category.categoryName
        config.secondaryText = category.description
        cell.contentConfiguration = config
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMealListVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? MealListTableViewController else { return }
            let category = viewModel.categories[indexPath.row]
            destinationVC.category = category
        }
    }
}

extension CategoryListTableViewController: CategoryListViewModelDelegate {
    func categoriesFetchedSuccessfully() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
