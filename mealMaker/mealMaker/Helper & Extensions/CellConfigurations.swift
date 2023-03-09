//
//  CellConfigurations.swift
//  mealMaker
//
//  Created by Chase on 3/9/23.
//

import UIKit

struct CellConfigurations {
    
    static func configCategoryCells(cell: UITableViewCell, category: Category) {
        var config = cell.defaultContentConfiguration()
        
        config.text = category.categoryName
        config.secondaryText = category.description
        cell.contentConfiguration = config
    }
}
