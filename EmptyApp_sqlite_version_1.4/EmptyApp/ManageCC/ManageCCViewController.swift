//
//  ManageCCViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class ManageCCViewController: UIViewController {
    @IBOutlet private var resultLabel: UILabel!
    @IBOutlet private var SearchCategoryField : UITextField?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addCategoryView(_ sender: UIButton) {
        let addCategoryViewController = AddCategoryViewController(nibName: "AddCategoryView", bundle: nil)
        navigationController?.pushViewController(addCategoryViewController, animated: true)
    }
    
    @IBAction func updateCategoryView(_ sender: UIButton) {
        let updateCategoryViewController = UpdateCategoryViewController(nibName: "UpdateCategoryView", bundle: nil)
        navigationController?.pushViewController(updateCategoryViewController, animated: true)
    }
    
    @IBAction func deleteCategoryView(_ sender: UIButton) {
        let deleteCategoryViewController = DeleteCategoryViewController(nibName: "DeleteCategoryView", bundle: nil)
        navigationController?.pushViewController(deleteCategoryViewController, animated: true)
    }
    
    @IBAction func displayCategories(_ sender: UIButton) {
        // Access the DatabaseManager instance
        let categories = DatabaseManager.shared.retrieveCourseCategories()

        // Create a string to display category information
        var categoriesInfo = "Categories Information:\n"

        for (index, category) in categories.enumerated() {
            categoriesInfo += "\n\(index + 1). Category ID: \(category.category_Id)\nName: \(category.name)\n"

        }

        // Update the resultLabel text to display category information
        resultLabel.text = categoriesInfo
    }
    
    @IBAction func selectCategoryView(_ sender: UIButton) {
        // Get the entered category ID
        guard let categoryIdText = SearchCategoryField?.text, let categoryId = Int(categoryIdText) else {
            showAlert(message: "Invalid input. Please enter a valid integer for Category ID.")
            return
        }

        // Access the DataModel singleton instance
        let dbManger = DatabaseManager.shared
        let categories = dbManger.retrieveCourseCategories()
        // Find the selected category by ID
        if let selectedCategory = categories.first(where: { $0.category_Id == categoryId }) {
            // Initialize the SelectedCategoryViewController
            let selectedCategoryViewController = SelectedCategoryViewController(nibName: "SelectedCategoryView", bundle: nil)
            selectedCategoryViewController.selectedCategory = selectedCategory
            // Navigate to the SelectedCategoryViewController
            navigationController?.pushViewController(selectedCategoryViewController, animated: true)
        } else {
            showAlert(message: "Category with ID \(categoryId) not found.")
        }
    }


    // Function to display an alert with a custom message
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
  
    

}
