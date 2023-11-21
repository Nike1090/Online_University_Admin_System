//
//  CategoriesAddViewController.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar  on 11/20/23.
//

import UIKit

class CategoriesAddViewController: UIViewController {

    @IBOutlet weak var categoryId: UITextField!
    @IBOutlet weak var categoryName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addCategory(_ sender: Any) {
        guard let categoryIDText = categoryId.text,
              let categoryID = Int(categoryIDText),
              let categoryName = categoryName.text,
              !categoryIDText.isEmpty,
              !categoryName.isEmpty else {
            showAlert(message: "Fill all fields.")
            return
        }

        do {
            // Access the shared instance of DatabaseManager
            let dbManager = DatabaseManager.shared

            // Retrieve all categories from the database
            let allCategories = dbManager.retrieveCourseCategories()

            // Check if the category ID already exists in the retrieved categories
            if allCategories.contains(where: { $0.category_Id == categoryID }) {
                showAlert(message: "Category with ID \(categoryID) already exists. Please choose a different ID.")
            } else {
                // Insert a new category into the database
                try dbManager.db?.run("INSERT INTO course_categories (category_Id, name) VALUES (?, ?)",
                                      categoryID, categoryName)

                showAlert(message: "\(categoryName) added successfully!")
            }
        } catch {
            print("Error adding category: \(error)")
            showAlert(message: "Error adding category. Please try again.")
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
