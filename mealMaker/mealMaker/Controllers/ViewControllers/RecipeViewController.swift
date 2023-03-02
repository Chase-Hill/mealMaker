//
//  RecipeViewController.swift
//  mealMaker
//
//  Created by Chase on 3/2/23.
//

import UIKit

class RecipeViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeAreaLabel: UILabel!
    @IBOutlet weak var recipeYTLink: UILabel!
    @IBOutlet weak var recipeInstructionsLabel: UILabel!
    @IBOutlet weak var ingredientsTableView: UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Properties
    var meal: Meal?
    
}
