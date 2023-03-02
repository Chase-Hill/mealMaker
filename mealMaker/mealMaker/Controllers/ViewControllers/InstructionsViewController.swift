//
//  InstructionsViewController.swift
//  mealMaker
//
//  Created by Chase on 3/2/23.
//

import UIKit

class InstructionsViewController: UIViewController {

    // MARK: - Outlet
    @IBOutlet weak var instructionsTextView: UITextView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    // MARK: - Properties
    var instructions: String?
    
    // MARK: - Function
    func updateUI() {
        guard let instructions = instructions else { return }
        instructionsTextView.text = instructions
    }
}
