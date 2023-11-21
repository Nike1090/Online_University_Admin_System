//
//  DatabaseManager.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/9/23.
//  Copyright © 2023 rab. All rights reserved.
//
import Foundation
import SQLite
import UIKit

class DatabaseManager {
    static let shared = DatabaseManager()
    var db: Connection?
    
    private init() {
        do {
            // Set the path to the SQLite database file
            let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let dbPath = URL(fileURLWithPath: path).appendingPathComponent("dataModel.sqlite").path
            
            // Create a database connection
            db = try Connection(dbPath)
            
            // Create tables
            try createTables()
            // dropCollegesTable()
            // Insert data
            insertInitialData()
            
        } catch {
            print("Error creating database connection: \(error)")
        }
    }
    
    func dropCollegesTable() {
        do {
            let colleges = Table("colleges")
            try db?.run(colleges.drop(ifExists: true))
            print("Colleges table dropped successfully.")
        } catch {
            print("Error dropping colleges table: \(error)")
        }
    }
    
    private func createTables() throws {
        do {
            // Create Colleges table
            let colleges = Table("colleges")
            let collegeId = Expression<Int>("college_Id")
            let collegeName = Expression<String>("name")
            let collegeAddress = Expression<String>("address")
            let collegeImage = Expression<Data?>("image")
            
            try db?.run(colleges.create(ifNotExists: true) { table in
                table.column(collegeId, primaryKey: true)
                table.column(collegeName)
                table.column(collegeAddress)
                table.column(collegeImage)
            })
            
            // Create Programs table
            let programs = Table("programs")
            let programId = Expression<Int>("program_Id")
            let programName = Expression<String>("name")
            let programCollegeId = Expression<Int>("college_Id")
            
            try db?.run(programs.create(ifNotExists: true) { table in
                table.column(programId, primaryKey: true)
                table.column(programName)
                table.column(programCollegeId, references: colleges, collegeId)
            })
            
            // Create Course_Category table
            let courseCategories = Table("course_categories")
            let categoryId = Expression<Int>("category_Id")
            let categoryName = Expression<String>("name")
            
            try db?.run(courseCategories.create(ifNotExists: true) { table in
                table.column(categoryId, primaryKey: true)
                table.column(categoryName)
            })
            
            // Create Courses table
            let courses = Table("courses")
            let courseId = Expression<Int>("course_Id")
            let courseName = Expression<String>("name")
            let courseCollegeId = Expression<Int>("college_Id")
            let courseProgramId = Expression<Int>("program_Id")
            let courseCategoryId = Expression<Int>("category_Id")
            
            try db?.run(courses.create(ifNotExists: true) { table in
                table.column(courseId, primaryKey: true)
                table.column(courseName)
                table.column(courseCollegeId, references: colleges, collegeId)
                table.column(courseProgramId, references: programs, programId)
                table.column(courseCategoryId, references: courseCategories, categoryId)
            })
            
        } catch {
            // Handle the error here
            print("Error creating tables: \(error)")
            throw error
        }
    }
    
    
    private func insertInitialData() {
        do {
            
            if let coeImage = UIImage(named: "c1.jpg"),let cpsImage = UIImage(named: "c2.jpg") {
                let coeImageData = coeImage.jpegData(compressionQuality: 0.5) // Convert image to Data format
                
                
                // Insert data into Colleges table
                let coe = Table("colleges")
                let insertCoe = coe.insert(or: .ignore, [
                    Expression<Int>("college_Id") <- 101,
                    Expression<String>("name") <- "COE",
                    Expression<String>("address") <- "150 Huntington",
                    Expression<Data?>("image") <- coeImageData
                ])
                
                try db?.run(insertCoe)
                
                
                let cpsImageData = cpsImage.jpegData(compressionQuality: 50) //
                
                let cps = Table("colleges")
                let insertCps = cps.insert(or: .ignore, [
                    Expression<Int>("college_Id") <- 102,
                    Expression<String>("name") <- "CPS",
                    Expression<String>("address") <- "140 Walter Street",
                    Expression<Data?>("image") <- cpsImageData
                    
                ])
                
                try db?.run(insertCps)
                
            }
            
            // Insert data into Programs table
            let programCOE1 = Table("programs")
            let insertProgramCOE1 = programCOE1.insert(or: .ignore, [
                Expression<Int>("program_Id") <- 320,
                Expression<String>("name") <- "CS",
                Expression<Int>("college_Id") <- 101
            ])
            
            try db?.run(insertProgramCOE1)
            
            let programCOE2 = Table("programs")
            let insertProgramCOE2 = programCOE2.insert(or: .ignore, [
                Expression<Int>("program_Id") <- 321,
                Expression<String>("name") <- "IS",
                Expression<Int>("college_Id") <- 101
            ])
            
            try db?.run(insertProgramCOE2)
            
            let programCPS1 = Table("programs")
            let insertProgramCPS1 = programCPS1.insert(or: .ignore, [
                Expression<Int>("program_Id") <- 420,
                Expression<String>("name") <- "DA",
                Expression<Int>("college_Id") <- 102
            ])
            
            try db?.run(insertProgramCPS1)
            
            let programCPS2 = Table("programs")
            let insertProgramCPS2 = programCPS2.insert(or: .ignore, [
                Expression<Int>("program_Id") <- 421,
                Expression<String>("name") <- "MA",
                Expression<Int>("college_Id") <- 102
            ])
            
            try db?.run(insertProgramCPS2)
            
            
            // Insert data into Course_Category table
            let categoryInfo1 = Table("course_categories")
            let insertCategoryInfo1 = categoryInfo1.insert(or: .ignore, [
                Expression<Int>("category_Id") <- 5000,
                Expression<String>("name") <- "INFO"
            ])
            
            try db?.run(insertCategoryInfo1)
            
            let categoryInfo2 = Table("course_categories")
            let insertCategoryInfo2 = categoryInfo2.insert(or: .ignore, [
                Expression<Int>("category_Id") <- 5001,
                Expression<String>("name") <- "CSE"
            ])
            
            try db?.run(insertCategoryInfo2)
            
            // Insert data into Courses table
            let coursesCOE1 = Table("courses")
            let insertCourse1 = coursesCOE1.insert(or: .ignore, [
                Expression<Int>("course_Id") <- 800,
                Expression<String>("name") <- "Web design",
                Expression<Int>("college_Id") <- 101,
                Expression<Int>("program_Id") <- 320,
                Expression<Int>("category_Id") <- 5000
            ])
            
            try db?.run(insertCourse1)
            
            let coursesCOE2 = Table("courses")
            let insertCourse2 = coursesCOE2.insert(or: .ignore, [
                Expression<Int>("course_Id") <- 801,
                Expression<String>("name") <- "Mobile design",
                Expression<Int>("college_Id") <- 101,
                Expression<Int>("program_Id") <- 320,
                Expression<Int>("category_Id") <- 5000
            ])
            
            try db?.run(insertCourse2)
            
            let coursesCPS1 = Table("courses")
            let insertCourse3 = coursesCPS1.insert(or: .ignore, [
                Expression<Int>("course_Id") <- 802,
                Expression<String>("name") <- "Web design",
                Expression<Int>("college_Id") <- 102,
                Expression<Int>("program_Id") <- 420,
                Expression<Int>("category_Id") <- 5001
            ])
            
            try db?.run(insertCourse3)
            
            let coursesCPS2 = Table("courses")
            let insertCourse4 = coursesCPS2.insert(or: .ignore, [
                Expression<Int>("course_Id") <- 803,
                Expression<String>("name") <- "Mobile design",
                Expression<Int>("college_Id") <- 102,
                Expression<Int>("program_Id") <- 420,
                Expression<Int>("category_Id") <- 5001
            ])
            
            try db?.run(insertCourse4)
            
        } catch {
            // Handle the error here
            print("Error inserting initial data: \(error)")
        }
    }
    
    func insertCollege(collegeId: Int, name: String, address: String, imageData: Data?) throws {
        let colleges = Table("colleges")
        let collegeIdExp = Expression<Int>("college_Id")
        let nameExp = Expression<String>("name")
        let addressExp = Expression<String>("address")
        let imageExp = Expression<Data?>("image")

        let insertCollege = colleges.insert(or: .ignore,
            collegeIdExp <- collegeId,
            nameExp <- name,
            addressExp <- address,
            imageExp <- imageData
        )

        try db?.run(insertCollege)
    }

    func updateCollege(collegeId: Int, newName: String, newAddress: String, newImageData: Data?) throws {
        let colleges = Table("colleges")
        let collegeIdExp = Expression<Int>("college_Id")
        let nameExp = Expression<String>("name")
        let addressExp = Expression<String>("address")
        let imageExp = Expression<Data?>("image")

        guard let db = self.db else {
            throw NSError(domain: "DatabaseError", code: 500, userInfo: [NSLocalizedDescriptionKey: "Database connection error"])
        }

        do {
            let collegeToUpdate = colleges.filter(collegeIdExp == collegeId)
            var updateStatement = collegeToUpdate.update(
                nameExp <- newName,
                addressExp <- newAddress,
                imageExp <- newImageData
            )

            try db.run(updateStatement)
        } catch {
            throw error
        }
    }

    
    func deleteCollege(_ college: College) {
        do {
            let colleges = Table("colleges")
            let collegeId = Expression<Int>("college_Id")
            
            // Construct the delete query
            let query = colleges.filter(collegeId == college.college_Id)
            
            // Execute the delete query
            try db?.run(query.delete())
        } catch {
            print("Error deleting college: \(error)")
        }
    }
    
    func deleteCourseCategory(_ category: Course_Category) {
        do {
            let categories = Table("course_categories")
            let categoryId = Expression<Int>("category_Id")
            
            // Construct the delete query
            let query = categories.filter(categoryId == category.category_Id)
            
            // Execute the delete query
            try db?.run(query.delete())
        } catch {
            print("Error deleting course category: \(error)")
        }
    }
    
    func deleteCourse(_ course: Course) {
            do {
                let courses = Table("courses")
                let courseId = Expression<Int>("course_Id")
                
                // Construct the delete query
                let query = courses.filter(courseId == course.course_Id)
                
                // Execute the delete query
                try db?.run(query.delete())
            } catch {
                print("Error deleting course: \(error)")
            }
        }
    
    func deleteProgram(_ program: Program) {
            do {
                let programs = Table("programs")
                let programId = Expression<Int>("program_Id")

                // Construct the delete query
                let query = programs.filter(programId == program.program_Id)

                // Execute the delete query
                try db?.run(query.delete())
            } catch {
                print("Error deleting program: \(error)")
            }
        }
    
    
    // Add this function to the DatabaseManager class
    func retrieveColleges() -> [College] {
        do {
            let colleges = Table("colleges")
            let collegeId = Expression<Int>("college_Id")
            let collegeName = Expression<String>("name")
            let collegeAddress = Expression<String>("address")
            let collegeImage = Expression<Data?>("image")
            let query = colleges.select(collegeId, collegeName, collegeAddress, collegeImage)
            
            let collegeRows = try db?.prepare(query)
            
            var result: [College] = []
            
            for row in collegeRows! {
                
                let image: UIImage? // Create a variable to store the converted image
                            
                            // Check if the image data exists
                            if let imageData = row[collegeImage] {
                                image = UIImage(data: imageData) // Convert Data to UIImage
                            } else {
                                image = nil // If no image data is available
                            }
                
                let college = College(
                    college_Id: row[collegeId],
                    name: row[collegeName],
                    address: row[collegeAddress],
                    image: image
                )
                result.append(college)
            }
            
            return result
        } catch {
            // Handle the error here
            print("Error retrieving colleges: \(error)")
            return []
        }
    }
    
    func retrievePrograms() -> [Program] {
        do {
            let programs = Table("programs")
            let programId = Expression<Int>("program_Id")
            let programName = Expression<String>("name")
            let programCollegeId = Expression<Int>("college_Id")
            
            let query = programs.select(programId, programName, programCollegeId)
            
            let programRows = try db?.prepare(query)
            
            var result: [Program] = []
            
            for row in programRows! {
                let program = Program(
                    program_Id: row[programId],
                    name: row[programName],
                    college_Id: row[programCollegeId]
                )
                result.append(program)
            }
            
            return result
        } catch {
            print("Error retrieving programs: \(error)")
            return []
        }
    }
    
    func retrieveCourseCategories() -> [Course_Category] {
        do {
            let courseCategories = Table("course_categories")
            let categoryId = Expression<Int>("category_Id")
            let categoryName = Expression<String>("name")
            
            let query = courseCategories.select(categoryId, categoryName)
            
            let categoryRows = try db?.prepare(query)
            
            var result: [Course_Category] = []
            
            for row in categoryRows! {
                let category = Course_Category(
                    category_Id: row[categoryId],
                    name: row[categoryName]
                )
                result.append(category)
            }
            
            return result
        } catch {
            print("Error retrieving course categories: \(error)")
            return []
        }
    }
    
    func retrieveCourses() -> [Course] {
        do {
            let courses = Table("courses")
            let courseId = Expression<Int>("course_Id")
            let courseName = Expression<String>("name")
            let courseCollegeId = Expression<Int>("college_Id")
            let courseProgramId = Expression<Int>("program_Id")
            let courseCategoryId = Expression<Int>("category_Id")
            
            let query = courses.select(courseId, courseName, courseCollegeId, courseProgramId, courseCategoryId)
            
            let courseRows = try db?.prepare(query)
            
            var result: [Course] = []
            
            for row in courseRows! {
                let course = Course(
                    course_Id: row[courseId],
                    name: row[courseName],
                    college_Id: row[courseCollegeId],
                    program_Id: row[courseProgramId],
                    category_Id: row[courseCategoryId]
                )
                result.append(course)
            }
            
            return result
        } catch {
            print("Error retrieving courses: \(error)")
            return []
        }
    }
    
    func retrieveStoredImages() -> [UIImage] {
        do {
            let colleges = Table("colleges")
            let collegeImage = Expression<Data?>("image")
            
            let query = colleges.select(collegeImage)
            let imageRows = try db?.prepare(query)
            
            var result: [UIImage] = []
            
            for row in imageRows! {
                if let imageData = row[collegeImage], let image = UIImage(data: imageData) {
                    result.append(image)
                }
            }
            
            return result
        } catch {
            print("Error retrieving stored images: \(error)")
            return []
        }
        
        
        
    }
}
