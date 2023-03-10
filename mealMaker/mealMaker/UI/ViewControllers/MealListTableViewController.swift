//
//  MealListTableViewController.swift
//  mealMaker
//
//  Created by Chase on 3/1/23.
//

import UIKit

class MealListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpActivityIndicator()
        fetchMealsInCategory()
    }

    // MARK: - Properties
    var category: Category?
    var mealArray: [Meal] = []
    var activityIndicator = UIActivityIndicatorView()
    let service = MealService()
    
    // MARK: - Functions
    func fetchMealsInCategory() {
        guard let category = category else { return }
        service.fetchMealsInCategory(forCategory: category) { [weak self] result in
            switch result {
            case .success(let meals):
                self?.mealArray = meals
                self?.stopAnimatingAndReloadData()
                
            case .failure(let error):
                print(error.errorDescription ?? NetworkError.unknownError)
            }
        }
    }
    
    func setUpActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        self.view.addSubview(activityIndicator)
        self.view.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
    }
    
    func stopAnimatingAndReloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath)

        let meal = mealArray[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = meal.mealName
        config.secondaryText = meal.mealID
        cell.contentConfiguration = config

        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipeVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? RecipeViewController else { return }
            let meal = mealArray[indexPath.row]
            destinationVC.meal = meal
        }
    }
}
