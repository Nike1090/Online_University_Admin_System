//
//  AddCategoryViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {

    @IBOutlet private var catIdField: UITextField!
    @IBOutlet private var catNameField: UITextField!

    @IBAction func addCategory(_ sender: UIButton) {
        // Get the category ID and name from the text fields
        guard let categoryIDText = catIdField.text, !categoryIDText.isEmpty,
              let categoryName = catNameField.text, !categoryName.isEmpty,
              let categoryID = Int(categoryIDText) else {
            showAlert(message: "Invalid input. Please fill all fields and enter a valid integer for Category ID.")
            return
        }

        // Access the DataModel singleton instance
        let dataModel = DataModel.shared

        // Check if a category with the same ID already exists
        if dataModel.categories.contains(where: { $0.category_Id == categoryID }) {
            showAlert(message: "Category with ID \(categoryID) already exists. Please choose a different ID.")
            return
        }

        // Create a new category and add it to the data model
        let newCategory = Course_Category(category_Id: categoryID, name: categoryName)
        dataModel.categories.append(newCategory)

        showAlert(message: "\(categoryName) added successfully!")

        // Clear the text fields
        catIdField.text = ""
        catNameField.text = ""
    }

    // Function to display an alert with a custom message
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

