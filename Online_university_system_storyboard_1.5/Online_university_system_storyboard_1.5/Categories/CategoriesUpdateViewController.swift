//
//  CategoriesUpdateViewController.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar on 11/20/23.
//

import UIKit

import UIKit

class CategoriesUpdateViewController: UIViewController  {

    var categoryIdInt: Int?
    var categoryNameText: String?
    
    @IBOutlet weak var categoryName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        categoryName.text = categoryNameText
    }

    @IBAction func updateCategory(_ sender: Any) {
        guard let categoryId = categoryIdInt, let categoryNameText = categoryName.text, !categoryNameText.isEmpty else {
            showAlert(message: "Invalid input. Please fill all fields.")
            return
        }

        do {
            let dbManager = DatabaseManager.shared
            let allCategories = dbManager.retrieveCourseCategories()
        
            if allCategories.firstIndex(where: { $0.category_Id == categoryId }) != nil {
                try dbManager.db?.run("UPDATE course_categories SET name = ? WHERE category_Id = ?", categoryNameText, categoryId)
                showAlert(message: "Category updated successfully!")
            }
         } catch {
            print("Error updating category: \(error)")
            showAlert(message: "Error updating category. Please try again.")
         }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
