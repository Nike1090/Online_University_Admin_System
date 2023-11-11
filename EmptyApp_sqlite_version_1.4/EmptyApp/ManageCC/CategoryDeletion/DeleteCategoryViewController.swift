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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func deleteCategory(_ sender: UIButton) {
        // Get the category ID from the text field
        guard let categoryIdText = categoryIdField.text, let categoryId = Int(categoryIdText) else {
            showAlert(message: "Invalid input. Please enter a valid integer for Category ID.")
            return
        }

        do {
            // Access the shared instance of DatabaseManager
            let dbManager = DatabaseManager.shared

            // Retrieve all categories from the database
            let allCategories = dbManager.retrieveCourseCategories()

            // Find the index of the category with the provided ID
            if let index = allCategories.firstIndex(where: { $0.category_Id == categoryId }) {
                let category = allCategories[index]

                // Retrieve courses associated with the category
                let courses = dbManager.retrieveCourses().filter { $0.category_Id == category.category_Id }

                // Check if the category has courses
                if courses.isEmpty {
                    // Delete the category
                    try dbManager.db?.run("DELETE FROM course_categories WHERE category_Id = ?", categoryId)
                    showAlert(message: "Category deleted successfully!")
                } else {
                    showAlert(message: "Cannot delete a category with courses. Please delete the courses first.")
                }
            } else {
                showAlert(message: "Category with ID \(categoryId) not found.")
            }
        } catch {
            print("Error deleting category: \(error)")
            showAlert(message: "Error deleting category. Please try again.")
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
