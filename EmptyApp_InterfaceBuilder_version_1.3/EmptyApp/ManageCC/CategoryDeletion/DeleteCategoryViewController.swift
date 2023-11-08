//
//  DeleteCategoryViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class DeleteCategoryViewController: UIViewController {

    @IBOutlet private var categoryIdField: UITextField!

    @IBAction func deleteCategory(_ sender: UIButton) {
        // Get the category ID from the text field
        guard let categoryIdText = categoryIdField.text, let categoryId = Int(categoryIdText) else {
            showAlert(message: "Invalid input. Please enter a valid integer for Category ID.")
            return
        }

        // Access the DataModel singleton instance
        let dataModel = DataModel.shared

        // Find the index of the category with the provided ID
        if let index = dataModel.categories.firstIndex(where: { $0.category_Id == categoryId }) {
            let category = dataModel.categories[index]

            // Check if the category has courses
            if category.courses.isEmpty {
                // Delete the category
                dataModel.categories.remove(at: index)
                showAlert(message: "Category deleted successfully!")
            } else {
                showAlert(message: "Cannot delete a category with courses. Please delete the courses first.")
            }
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
