//
//  CategoriesTableViewController.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar on 11/20/23.
//

import UIKit

class CategoriesTableViewController: UITableViewController {

    var courseCategories: [Course_Category] = []

        override func viewDidLoad() {
            super.viewDidLoad()

            // Populate 'courseCategories' array with data retrieved from DatabaseManager
            courseCategories = DatabaseManager.shared.retrieveCourseCategories()

            // Register the UITableViewCell subclass or reuse identifier
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload table data to reflect any changes (e.g., new college added)
        courseCategories = DatabaseManager.shared.retrieveCourseCategories()
        tableView.reloadData()
    }
    
        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1 // Assuming a single section for course categories
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return courseCategories.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

            let category = courseCategories[indexPath.row]
            cell.textLabel?.text = "\(category.category_Id) - \(category.name)"

            return cell
        }

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let categoryToRemove = courseCategories[indexPath.row]
                let categoryId = categoryToRemove.category_Id

                // Retrieve courses associated with the category
                let courses = DatabaseManager.shared.retrieveCourses().filter { $0.category_Id == categoryId }

                if courses.isEmpty {
                    // Delete the corresponding data from DatabaseManager
                    DatabaseManager.shared.deleteCourseCategory(categoryToRemove)

                    // Remove the item from the data source
                    courseCategories.remove(at: indexPath.row)

                    // Delete the row from the table view
                    tableView.deleteRows(at: [indexPath], with: .fade)

                    showAlert(message: "Course Category deleted successfully!")
                } else {
                    showAlert(message: "Cannot delete. Course Category has associated courses.")
                }
            }
        }

        private func showAlert(message: String) {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CategoriesUpdateViewController", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CategoriesUpdateViewController" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let category = courseCategories[indexPath.row]
                if let categoryCoursesVC = segue.destination as? CategoriesUpdateViewController {
                    categoryCoursesVC.categoryIdInt = category.category_Id
                    categoryCoursesVC.categoryNameText = category.name
                    
                }
            }
        }
    }
}
