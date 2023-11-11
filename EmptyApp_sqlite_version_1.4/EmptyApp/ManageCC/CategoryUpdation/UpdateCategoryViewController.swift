//
//  UpdateCategoryViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class UpdateCategoryViewController: UIViewController {

    @IBOutlet private var categoryIdField: UITextField!
    @IBOutlet private var categoryNameField: UITextField!

    @IBAction func fetchCategory(_ sender: UIButton) {
        // Get the category ID from the text field
        guard let categoryIdText = categoryIdField.text, let categoryId = Int(categoryIdText) else {
            showAlert(message: "Invalid input. Please enter a valid integer for Category ID.")
            return
        }

        
            // Access the shared instance of DatabaseManager
            let dbManager = DatabaseManager.shared

            // Retrieve all categories from the database
            let allCategories = dbManager.retrieveCourseCategories()

            // Find the category with the provided ID
            if let category = allCategories.first(where: { $0.category_Id == categoryId }) {
                // Populate the category name field with the fetched name
                categoryNameField.text = category.name
            } else {
                showAlert(message: "Category with ID \(categoryId) not found.")
            }
        
    }

    @IBAction func updateCategory(_ sender: UIButton) {
        // Get the category ID and updated name from the text fields
        guard let categoryIdText = categoryIdField.text, let categoryId = Int(categoryIdText),
              let updatedName = categoryNameField.text, !updatedName.isEmpty else {
            showAlert(message: "Invalid input. Please enter a valid integer for Category ID and provide an updated name.")
            return
        }

        do {
            // Access the shared instance of DatabaseManager
            let dbManager = DatabaseManager.shared

            // Retrieve all categories from the database
            let allCategories = dbManager.retrieveCourseCategories()

            // Find the index of the category with the provided ID
            if let index = allCategories.firstIndex(where: { $0.category_Id == categoryId }) {
                // Update the category name in the database
                try dbManager.db?.run("UPDATE course_categories SET name = ? WHERE category_Id = ?", updatedName, categoryId)

                showAlert(message: "Category updated successfully!")
            } else {
                showAlert(message: "Category with ID \(categoryId) not found.")
            }
        } catch {
            print("Error updating category: \(error)")
            showAlert(message: "Error updating category. Please try again.")
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
