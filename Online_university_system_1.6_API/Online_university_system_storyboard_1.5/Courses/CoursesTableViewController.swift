//
//  CoursesTableViewController.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar on 11/20/23.
//

import UIKit

class CoursesTableViewController: UITableViewController {

    var courses: [Course] = [] // Array to hold Course objects
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve courses from DatabaseManager
        courses = DatabaseManager.shared.retrieveCourses()
        
        // Register the UITableViewCell subclass or reuse identifier
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CourseCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload table data to reflect any changes (e.g., new college added)
        courses = DatabaseManager.shared.retrieveCourses()
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Assuming a single section for courses
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CourseCell", for: indexPath)

        let course = courses[indexPath.row]
        cell.textLabel?.text = "\(course.course_Id) - \(course.name)"
        // Add more information to the cell if needed
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let courseToRemove = courses[indexPath.row]
            
            // Delete the corresponding data from DatabaseManager
            DatabaseManager.shared.deleteCourse(courseToRemove)
            
            // Remove the item from the data source
            courses.remove(at: indexPath.row)
            
            // Delete the row from the table view
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            showAlert(message: "Course deleted successfully!")
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CoursesUpdateViewController", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CoursesUpdateViewController" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let course = courses[indexPath.row]
                if let updateCourseVC = segue.destination as? CoursesUpdateViewController {
                    // Pass the necessary information to the update view controller
                    updateCourseVC.courseIdInt = course.course_Id
                    updateCourseVC.courseNameText = course.name
                    updateCourseVC.collegeIdInt = course.college_Id
                    updateCourseVC.programIdInt = course.program_Id
                    updateCourseVC.categoryIdInt = course.category_Id
                }
            }
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
