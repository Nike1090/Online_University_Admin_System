//
//  SearchViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/6/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet private var searchCollegeField: UITextField!
    @IBOutlet private var searchProgramField: UITextField!
    @IBOutlet private var searchCourseField: UITextField!
    @IBOutlet private var searchCategoryField: UITextField!
    @IBOutlet private var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    @IBAction private func searchCollegeBtn() {
            // Handle College Search Field logic
            let colleges = DatabaseManager.shared.retrieveColleges()
            if let searchName = searchCollegeField.text, !searchName.isEmpty {
                var foundColleges: [College] = []
                
                for college in colleges {
                    if college.name.lowercased().contains(searchName.lowercased()) {
                        foundColleges.append(college)
                    }
                }
                
                if foundColleges.isEmpty {
                    resultLabel.text = "No colleges found with the name '\(searchName)'."
                } else {
                    var infoText = "Colleges found with the name '\(searchName)':\n"
                    for (index, college) in foundColleges.enumerated() {
                        infoText.append("\(index + 1). College ID: \(college.college_Id)\nName: \(college.name)\nAddress: \(college.address)\n")
                    }
                    resultLabel.text = infoText
                }
            } else {
                resultLabel.text = "Invalid input for college Name. Please try again."
            }
        }

        @IBAction private func searchProgramBtn() {
            // Handle Program Search Field logic
            let programs = DatabaseManager.shared.retrievePrograms()
            if let searchName = searchProgramField.text, !searchName.isEmpty {
                var foundPrograms: [Program] = []
                
                for program in programs {
                    if program.name.lowercased().contains(searchName.lowercased()) {
                        foundPrograms.append(program)
                    }
                }
                
                if foundPrograms.isEmpty {
                    resultLabel.text = "No programs found with the name '\(searchName)'."
                } else {
                    var infoText = "Programs found with the name '\(searchName)':\n"
                    for (index, program) in foundPrograms.enumerated() {
                        infoText.append("\(index + 1). Program ID: \(program.program_Id) Name: \(program.name) College ID: \(program.college_Id)\n")
                    }
                    resultLabel.text = infoText
                }
            } else {
                resultLabel.text = "Invalid input for Program Name. Please try again."
            }
        }
        
        @IBAction private func searchCourseBtn() {
            // Handle Course Search Field logic
            let courses = DatabaseManager.shared.retrieveCourses()
            if let searchName = searchCourseField.text, !searchName.isEmpty {
                var foundCourses: [Course] = []

                for course in courses {
                    if course.name.lowercased().contains(searchName.lowercased()) {
                        foundCourses.append(course)
                    }
                }

                if foundCourses.isEmpty {
                    resultLabel.text = "No courses found with the name '\(searchName)'."
                } else {
                    var infoText = "Courses found with the name '\(searchName)':\n"
                    for (index, course) in foundCourses.enumerated() {
                        infoText.append("\(index + 1). Course ID: \(course.course_Id) Name: \(course.name) College ID: \(course.college_Id) Program ID: \(course.program_Id) Category ID: \(course.category_Id)\n")
                    }
                    resultLabel.text = infoText
                }
            } else {
                resultLabel.text = "Invalid input for Course Name. Please try again."
            }
        }

    @IBAction private func searchCategoryBtn() {
        // Handle Category Search Field logic
        let categories = DatabaseManager.shared.retrieveCourseCategories()
        let courses = DatabaseManager.shared.retrieveCourses()

        if let searchName = searchCategoryField.text, !searchName.isEmpty {
            var foundCategories: [Course_Category] = []

            for category in categories {
                if category.name.lowercased().contains(searchName.lowercased()) {
                    foundCategories.append(category)
                }
            }

            if foundCategories.isEmpty {
                resultLabel.text = "No Categories found with the name '\(searchName)'."
            } else {
                var infoText = "Categories found with the name '\(searchName)':\n"

                for (index, category) in foundCategories.enumerated() {
                    infoText.append("\(index + 1). Category ID: \(category.category_Id)\nName: \(category.name)\n")

                    // Retrieve courses associated with the category
                    let categoryCourses = courses.filter { $0.category_Id == category.category_Id }

                    infoText.append("Courses under this Category name: \(category.name)\n")

                    for course in categoryCourses {
                        infoText.append("Course: \(course.name)\n")
                    }
                }

                resultLabel.text = infoText
            }
        } else {
            resultLabel.text = "Invalid input for Category Name. Please try again."
        }
    }

    }
    

