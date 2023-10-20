import Foundation

// Class to represent Course
class Course {
    var course_Id: Int
    var name: String
    var college_Id: Int
    var program_Id: Int
    var category_Id: Int
    
    init(course_Id: Int, name: String, college_Id: Int, program_Id: Int, category_Id: Int) {
        self.course_Id = course_Id
        self.name = name
        self.college_Id = college_Id
        self.program_Id = program_Id
        self.category_Id = category_Id
    }
}

// Class to represent Program
class Course_Category {
    var category_Id: Int
    var name: String
    var courses: [Course] = []
    
    init(category_Id: Int, name: String) {
        self.category_Id = category_Id
        self.name = name
    }
}

// Class to represent Program
class Program {
    var program_Id: Int
    var name: String
    var college_Id: Int
    
    init(program_Id: Int, name: String, college_Id: Int) {
        self.program_Id = program_Id
        self.name = name
        self.college_Id = college_Id
    }
}

// Class to represent College
class College {
    var college_Id: Int
    var name: String
    var address: String
    var programs: [Program] = []
    
    init(college_Id: Int, name: String, address: String) {
        self.college_Id = college_Id
        self.name = name
        self.address = address
    }
}

// Class to represent Admin User
class AdminUser {
    let email: String
    let password: String

    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}





// Main University Admin System class
class UniversityAdminSystem {
    private var colleges: [College] = []
    private var categories: [Course_Category] = []
    private var MasterOrderProgramsList: [Program] = []
    private var MasterOrderCourseList: [Course] = []
    private var currentUser: AdminUser?

    func run() {
        print("Welcome to the University Admin System!")

        // Create an initial college with some data
        let initialCollege1 = College(college_Id: 101, name: "COE", address: "150 Huntington")
        let program1 = Program(program_Id: 320, name: "CS", college_Id: initialCollege1.college_Id)
        let program2 = Program(program_Id: 321, name: "IS", college_Id: initialCollege1.college_Id)

        initialCollege1.programs.append(program1)
        initialCollege1.programs.append(program2)
        colleges.append(initialCollege1)
        
        MasterOrderProgramsList.append(program1)
        MasterOrderProgramsList.append(program2)
        
        

        let initialCollege2 = College(college_Id: 102, name: "CPS", address: "140 walter street")
        let program3 = Program(program_Id: 420, name: "DA", college_Id: initialCollege2.college_Id)
        let program4 = Program(program_Id: 421, name: "MA", college_Id: initialCollege2.college_Id)

        initialCollege2.programs.append(program3)
        initialCollege2.programs.append(program4)
        colleges.append(initialCollege2)
        
         MasterOrderProgramsList.append(program3)
         MasterOrderProgramsList.append(program4)

        // Create categories and courses with some data

        //category1
        let category1 = Course_Category(category_Id: 5000, name: "INFO")
        let course1 = Course(course_Id: 800, name: "Web design", college_Id: initialCollege1.college_Id, program_Id: program2.program_Id, category_Id: category1.category_Id)
        let course2 = Course(course_Id: 801, name: "mobile design", college_Id: initialCollege1.college_Id, program_Id: program2.program_Id, category_Id: category1.category_Id)
        
        categories.append(category1)

        category1.courses.append(course1)
        category1.courses.append(course2)

        //category2
        let category2 = Course_Category(category_Id: 5001, name: "CSE")
        let course3 = Course(course_Id: 802, name: "OS", college_Id: initialCollege1.college_Id, program_Id: program1.program_Id, category_Id: category2.category_Id)
        let course4 = Course(course_Id: 803, name: "networks", college_Id: initialCollege1.college_Id, program_Id: program1.program_Id, category_Id: category2.category_Id)

        categories.append(category2)

        category2.courses.append(course3)
        category2.courses.append(course4)

        //category3
        let category3 = Course_Category(category_Id: 5002, name: "CPSE")
        let course5 = Course(course_Id: 804, name: "data analysis", college_Id: initialCollege2.college_Id, program_Id: program3.program_Id, category_Id: category3.category_Id)
        let course6 = Course(course_Id: 805, name: "data mining", college_Id: initialCollege2.college_Id, program_Id: program3.program_Id, category_Id: category3.category_Id)

        categories.append(category3)
        
        category3.courses.append(course5)
        category3.courses.append(course6)

        //category4
        let category4 = Course_Category(category_Id: 5003, name: "CSP")
        let course7 = Course(course_Id: 806, name: "Web design", college_Id: initialCollege2.college_Id, program_Id: program4.program_Id, category_Id: category4.category_Id)
        let course8 = Course(course_Id: 807, name: "mobile design", college_Id: initialCollege2.college_Id, program_Id: program4.program_Id, category_Id: category4.category_Id)

        categories.append(category4)

        category4.courses.append(course7)
        category4.courses.append(course8)

        MasterOrderCourseList.append(course1)
        MasterOrderCourseList.append(course2)
        MasterOrderCourseList.append(course3)
        MasterOrderCourseList.append(course4)
        MasterOrderCourseList.append(course5)
        MasterOrderCourseList.append(course6)
        MasterOrderCourseList.append(course7)
        MasterOrderCourseList.append(course8)

        login()

        if currentUser != nil {
            mainMenu()
        }
    }

    func login() {
        print("\nPlease log in as an admin:")
        print("Enter your email address:")
        if let email = readLine(), email == "admin@gmail.com" {
            print("Enter your password:")
            if let password = readLine(), password == "admin123" {
                currentUser = AdminUser(email: email, password: password)
                print("Login successful!")
            } else {
                print("Login failed. Incorrect password.")
                login()
            }
        } else {
            print("Login failed. Incorrect email.")
            login()
        }
    }

    func mainMenu() {
        print("\nMain Menu:")
        print("1. Manage Colleges")
        print("2. Manage Course Category")
        print("3. Search by")
        print("4. Exit")
        print("Enter your choice (1/2/3/4):")

        if let choice = readLine(), let option = Int(choice) {
            switch option {
            case 1:
                manageColleges()
            case 2:
                manageCourseCategory()
            case 3:
                searchBy()
            case 4:
                print("see you around!")
                return
            default:
                print("Invalid choice. Please try again.")
                mainMenu()
            }
        } else {
            print("Invalid input. Please try again.")
            mainMenu()
        }
    }

    func manageColleges() {
        print("\nManage Colleges:")
        print("1. Display All Colleges")
        print("2. Add a College")
        print("3. Update a College")
        print("4. Delete a College")
        print("5. Select a College")
        print("6. Back to Main Menu")
        print("Enter your choice (1/2/3/4/5/6):")

        if let choice = readLine(), let option = Int(choice) {
            switch option {
            case 1:
                displayAllColleges()
            case 2:
                addCollege()
            case 3:
                updateCollege()
            case 4:
                deleteCollege()
            case 5:
                selectCollege()
            case 6:
                mainMenu()
            default:
                print("Invalid choice. Please try again.")
                manageColleges()
            }
        } else {
            print("Invalid input. Please try again.")
            manageColleges()
        }
    }

    func displayAllColleges() {
        print("\nAll Colleges:")
        for (index, college) in colleges.enumerated() {
            print("\(index + 1). college ID: \(college.college_Id) Name: \(college.name) Address: \(college.address)")
        }
        manageColleges()
    }

    func addCollege() {
    print("\nEnter the id of the College to add:")
    if let input = readLine(), let college_Id = Int(input) {
        // Check if the provided college_Id is unique
        if !colleges.contains(where: { $0.college_Id == college_Id }) {
            print("\nEnter the name of the College to add:")
            if let name = readLine() {
                print("\nEnter the address for the College to add:")
                if let address = readLine() {
                    let newCollege = College(college_Id: college_Id, name: name, address: address)
                    colleges.append(newCollege)
                    print("\(name) added successfully!")
                } else {
                    print("Invalid input. Please try again.")
                }
            } else {
                print("Invalid input. Please try again.")
            }
        } else {
            print("College with ID \(college_Id) already exists. Please choose a different ID.")
            addCollege()
        }
    } else {
        print("Invalid input. Please try again.")
    }
    
    manageColleges()
}


    func updateCollege() {
    
    
        print("\nEnter the index of the College to update:")
        if let input = readLine(), let index = Int(input), index > 0, index <= colleges.count {
        print("\nEnter the id of the College to Update:")
    if let input = readLine(), let newCollege_Id = Int(input) {
        // Check if the provided college_Id is unique
        if !colleges.contains(where: { $0.college_Id == newCollege_Id }) {
            
            let college = colleges[index - 1]
            college.college_Id = newCollege_Id
            print("Enter the new name for \(college.name):")
            if let newName = readLine() {
                college.name = newName
                print("Enter the new address for \(college.address):")
                if let newAddress = readLine() {
                    college.address = newAddress
                    print("College updated successfully!")
                }
                else {
                    print("Invalid input. Please try again.")
                }
            } else {
                print("Invalid input. Please try again.")
            }
            }
            else {
            print("College with that ID already exists. Please choose a different ID.")
            updateCollege()
        }
    
        manageColleges()
    }
    else {
            print("Invalid input. Please try again.")
        }
    
    }
    
    }

    func deleteCollege() {
        print("\nEnter the index of the College to delete:")
        if let input = readLine(), let index = Int(input), index > 0, index <= colleges.count {
            let college = colleges[index - 1]
            if college.programs.isEmpty {
                colleges.remove(at: index - 1)
                print("College deleted successfully!")
            } else {
                print("Cannot delete a college with programs. Please delete the programs first.")
            }
        } else {
            print("Invalid input. Please try again.")
        }
        manageColleges()
    }

    func selectCollege() {
        print("\nEnter the index of the College to select:")
        if let input = readLine(), let index = Int(input), index > 0, index <= colleges.count {
            let college = colleges[index - 1]
            print("Selected College: \(college.name)")
            collegeMenu(college)
        } else {
            print("Invalid input. Please try again.")
            manageColleges()
        }
    }

    func collegeMenu(_ college: College) {
        print("\nCollege Menu for \(college.name):")
        print("1. Display All Programs")
        print("2. Add a Program")
        print("3. Update a Program")
        print("4. Delete a Program")
        print("5. Back to Manage Colleges")
        print("Enter your choice (1/2/3/4/5/6):")

        if let choice = readLine(), let option = Int(choice) {
            switch option {
            case 1:
                displayAllPrograms(college)
            case 2:
                addProgram(college)
            case 3:
                updateProgram(college)
            case 4:
                deleteProgram(college)
            case 5:
                manageColleges()
            default:
                print("Invalid choice. Please try again.")
                collegeMenu(college)
            }
        } else {
            print("Invalid input. Please try again.")
            collegeMenu(college)
        }
    }

    func displayAllPrograms(_ college: College) {
        print("\nAll Programs in \(college.name):")
        for (index, program) in college.programs.enumerated() {
            print("\(index + 1). Program Id: \(program.program_Id) Name: \(program.name) college ID: \(program.college_Id)")
        }
        collegeMenu(college)
    }

    func addProgram(_ college: College) {
        print("\nEnter the id for the program to add:")
        if let input = readLine(), let program_Id = Int(input) {
        // Check if the provided program_Id is unique
        if !college.programs.contains(where: {$0.program_Id == program_Id}) {
        print("\nEnter the name of the Program to add:")
        if let name = readLine() {
    print("\nEnter the college_id you want the program to be added:")
        if let inp = readLine(), let choosenCollege_Id = Int(inp) {
        if colleges.contains(where: { $0.college_Id == choosenCollege_Id }) {
            let newProgram = Program(program_Id: program_Id,name:name,college_Id:choosenCollege_Id)
            college.programs.append(newProgram)
            MasterOrderProgramsList.append(newProgram)
            print("\(newProgram.name) added successfully to \(college.name)!")
            
            }
            else {
                    print("Only choose college ids from given college list")
                    addProgram(college)
                }
            }
            else {
                print("Invalid input. Please try again.")
            }
        } else {
            print("Invalid input. Please try again.")
        }
        collegeMenu(college)
        } else {
            print("Progam with that ID already exists. Please choose a different ID.")
            addProgram(college)
        }
        
        }
        else {
            print("Invalid input. Please try again.")
        }
        
    }

    func updateProgram(_ college: College) {
        print("\nEnter the index of the Program to update:")
        if let input = readLine(), let index = Int(input), index > 0, index <= college.programs.count {
        let program = college.programs[index - 1]
        
        print("\nEnter the new id for the program to Update for \(program.program_Id):")
       
        if let input = readLine(), let newProgram_Id = Int(input) {
        // Check if the provided program_Id is unique
        if !college.programs.contains(where: {$0.program_Id == newProgram_Id}) {
            let oldProgram = program    
            program.program_Id = newProgram_Id
            print("Enter the new name for \(program.name):")
            if let newName = readLine() {
                program.name = newName
            print("\nEnter the college_id you want the program to be update:")
                if let inp = readLine(), let choosenCollege_Id = Int(inp) {
                if colleges.contains(where: { $0.college_Id == choosenCollege_Id }) {
                program.college_Id = choosenCollege_Id
                print("Program updated successfully!")
                if let indexInMasterList = MasterOrderProgramsList.firstIndex(where: { $0.program_Id == oldProgram.program_Id }) {
                                        // Find the index of the old program in the MasterOrderProgramsList.
                                        MasterOrderProgramsList[indexInMasterList] = program
                                        // Replace the old program with the updated program in the MasterOrderProgramsList.
                                    }
                }
                else {
                    print("Only choose college ids from given college list")
                    updateProgram(college)
                }
            }
            else {
                print("Invalid input. Please try again.")
            }
               
            } else {
                print("Invalid input. Please try again.")
            }
        }
        else {
            print("Progam with that ID already exists. Please choose a different ID.")
            updateProgram(college)
        }
        
         } else {
            print("Invalid input. Please try again.")
        } 
         
        } else {
            print("Invalid input. Please try again.")
        }
        collegeMenu(college)
    }

    func deleteProgram(_ college: College) {
        print("\nEnter the index of the Program to delete:")
        if let input = readLine(), let index = Int(input), index > 0, index <= college.programs.count {
                let program = college.programs[index - 1]
                let oldProgram = program
                college.programs.remove(at: index - 1)
                print("Program deleted successfully!")
                if let indexInMasterList = MasterOrderProgramsList.firstIndex(where: { $0.program_Id == oldProgram.program_Id }) {
                                        // Find the index of the old program in the MasterOrderProgramsList.
                                        MasterOrderProgramsList.remove(at: indexInMasterList)
                                        // remove the program from  MasterOrderProgramsList as well.
                                    }
        } else {
            print("Invalid input. Please try again.")
        }
        collegeMenu(college)
    }

func manageCourseCategory() {
    print("\nManage Categories:")
    print("1. Display All Categories")
    print("2. Add a Category")
    print("3. Update a Category")
    print("4. Delete a Category")
    print("5. Select a Category")
    print("6. Back to Main Menu")
    print("Enter your choice (1/2/3/4/5/6):")

    if let choice = readLine(), let option = Int(choice) {
        switch option {
        case 1:
            displayAllCategories()
        case 2:
            addCategory()
        case 3:
            updateCategory()
        case 4:
            deleteCategory()
        case 5:
            selectCategory()
        case 6:
            mainMenu()
        default:
            print("Invalid choice. Please try again.")
            manageCourseCategory()
        }
    } else {
        print("Invalid input. Please try again.")
        manageCourseCategory()
    }
}

func displayAllCategories() {
    print("\nAll Categories:")
    for (index, category) in categories.enumerated() {
        print("\(index + 1). Category ID: \(category.category_Id) Name: \(category.name)")
    }
    manageCourseCategory()
}

func addCategory() {
    print("\nEnter the ID for the category to add:")
    if let input = readLine(), let category_Id = Int(input) {
        // Check if the provided category_Id is unique
        if !categories.contains(where: { $0.category_Id == category_Id }) {
            print("\nEnter the name of the Category to add:")
            if let name = readLine() {
                let newCategory = Course_Category(category_Id: category_Id, name: name)
                categories.append(newCategory)
                print("\(newCategory.name) added successfully!")
            } else {
                print("Invalid input. Please try again.")
            }
        } else {
            print("Category with ID \(category_Id) already exists. Please choose a different ID.")
            addCategory()
        }
    } else {
        print("Invalid input. Please try again.")
    }
    manageCourseCategory()
}

func updateCategory() {
    print("\nEnter the index of the Category to update:")
    if let input = readLine(), let index = Int(input), index > 0, index <= categories.count {
        let category = categories[index - 1]
        print("\nEnter the new ID for the category to update:")
        if let input = readLine(), let newCategory_Id = Int(input) {
            // Check if the provided category_Id is unique
            if !categories.contains(where: { $0.category_Id == newCategory_Id }) {
                category.category_Id = newCategory_Id
                print("Enter the new name for \(category.name):")
                if let newName = readLine() {
                    category.name = newName
                    print("Category updated successfully!")
                } else {
                    print("Invalid input. Please try again.")
                }
            } else {
                print("Category with that ID already exists. Please choose a different ID.")
                updateCategory()
            }
        } else {
            print("Invalid input. Please try again.")
        }
    } else {
        print("Invalid input. Please try again.")
    }
    manageCourseCategory()
}

func deleteCategory() {
    print("\nEnter the index of the Category to delete:")
    if let input = readLine(), let index = Int(input), index > 0, index <= categories.count {
        let category = categories[index - 1]
        if category.courses.isEmpty {
            categories.remove(at: index - 1)
            print("Category deleted successfully!")
        } else {
            print("Cannot delete a category with courses. Please delete the courses first.")
        }
    } else {
        print("Invalid input. Please try again.")
    }
    manageCourseCategory()
}

func selectCategory() {
    print("\nEnter the index of the Category to select:")
    if let input = readLine(), let index = Int(input), index > 0, index <= categories.count {
        let category = categories[index - 1]
        print("Selected Category: \(category.name)")
        CourseMenu(category)
    } else {
        print("Invalid input. Please try again.")
        manageCourseCategory()
    }
}

func CourseMenu(_ category: Course_Category) {
    print("\nManage Courses for \(category.name):")
    print("1. Display All Courses")
    print("2. Add a Course")
    print("3. Update a Course")
    print("4. Delete a Course")
    print("5. Back to Manage Categories")
    print("Enter your choice (1/2/3/4/5):")

    if let choice = readLine(), let option = Int(choice) {
        switch option {
        case 1:
            displayAllCourses(category)
        case 2:
            addCourse(category)
        case 3:
            updateCourse(category)
        case 4:
            deleteCourse(category)
        case 5:
            manageCourseCategory()
        default:
            print("Invalid choice. Please try again.")
            CourseMenu(category)
        }
    } else {
        print("Invalid input. Please try again.")
        CourseMenu(category)
    }
}

func displayAllCourses(_ category: Course_Category) {
    print("\nAll Courses in \(category.name):")
    for (index, course) in category.courses.enumerated() {
        print("\(index + 1). Course ID: \(course.course_Id)")
        print("   Name: \(course.name)")
        print("   College ID: \(course.college_Id)")
        print("   Program ID: \(course.program_Id)")
        print("   Category ID: \(course.category_Id)")
    }
    CourseMenu(category)
}

func addCourse(_ category: Course_Category) {
    print("\nEnter the ID for the course to add:")
    if let input = readLine(), let course_Id = Int(input) {
        // Check if the provided course_Id is unique
        if !category.courses.contains(where: { $0.course_Id == course_Id }) {
            print("\nEnter the name of the Course to add:")
            if let name = readLine() {
                print("\nEnter the College ID for the Course:")
                if let collegeIdInput = readLine(), let college_Id = Int(collegeIdInput) {
                    if colleges.contains(where: { $0.college_Id == college_Id }) {
                        let validProgramIds: [Int]
                        if let college = colleges.first(where: { $0.college_Id == college_Id }) {
                            // College found, get program IDs within this college
                            validProgramIds = college.programs.map { $0.program_Id }
                        } else {
                            // This should not be reached, but if it is, we'll allow any program ID
                            validProgramIds = []
                        }

                        print("\nEnter the Program ID for the Course:")
                        if let programIdInput = readLine(), let program_Id = Int(programIdInput) {
                            if validProgramIds.isEmpty || validProgramIds.contains(program_Id) {
                                // College or program ID is valid, proceed with adding the course
                                let newCourse = Course(course_Id: course_Id, name: name, college_Id: college_Id, program_Id: program_Id, category_Id: category.category_Id)
                                category.courses.append(newCourse)
                                MasterOrderCourseList.append(newCourse)
                                print("\(newCourse.name) added successfully to \(category.name)!")
                            } else {
                                print("Invalid Program ID. Please choose a valid Program ID for the selected College.")
                            }
                        } else {
                            print("Invalid input for Program ID. Please try again.")
                        }
                    } else {
                        print("Invalid College ID. Please choose a valid College ID from the list of colleges.")
                    }
                } else {
                    print("Invalid input for College ID. Please try again.")
                }
            } else {
                print("Invalid input for Course Name. Please try again.")
            }
        } else {
            print("Course with ID \(course_Id) already exists. Please choose a different ID.")
        }
    } else {
        print("Invalid input for Course ID. Please try again.")
    }
    CourseMenu(category)
}

func updateCourse(_ category: Course_Category) {
    print("\nEnter the index of the Course to update:")
    if let input = readLine(), let index = Int(input), index > 0, index <= category.courses.count {
        let course = category.courses[index - 1]

        print("\nEnter the new ID for the course to Update for \(course.course_Id):")
        if let courseIdInput = readLine(), let newCourse_Id = Int(courseIdInput) {
            // Check if the provided course_Id is unique
            if !category.courses.contains(where: { $0.course_Id == newCourse_Id }) {
                let oldCourse = course
                course.course_Id = newCourse_Id
                print("Enter the new name for \(course.name):")
                if let newName = readLine() {
                    course.name = newName

                    print("\nEnter the College ID for the Course:")
                    if let collegeIdInput = readLine(), let newCollege_Id = Int(collegeIdInput) {
                        if colleges.contains(where: { $0.college_Id == newCollege_Id }) {
                            let validProgramIds: [Int]
                            if let college = colleges.first(where: { $0.college_Id == newCollege_Id }) {
                                // College found, get program IDs within this college
                                validProgramIds = college.programs.map { $0.program_Id }
                            } else {
                                // This should not be reached, but if it is, we'll allow any program ID
                                validProgramIds = []
                            }

                            print("\nEnter the new Program ID for the Course:")
                            if let programIdInput = readLine(), let newProgram_Id = Int(programIdInput) {
                                if validProgramIds.isEmpty || validProgramIds.contains(newProgram_Id) {
                                    // College or program ID is valid, proceed with updating the course
                                    course.college_Id = newCollege_Id
                                    course.program_Id = newProgram_Id
                                    print("Course updated successfully!")
                                    
                                    if let indexInMasterList = MasterOrderCourseList.firstIndex(where: { $0.course_Id == oldCourse.course_Id }) {
                                        // Find the index of the old course in the MasterOrderCourseList.
                                        
                                        MasterOrderCourseList[indexInMasterList] = course
                                        // Replace the old course with the updated course in the MasterOrderCourseList.
                                    }
                                    
                                } else {
                                    print("Invalid Program ID. Please choose a valid Program ID for the selected College.")
                                }
                            } else {
                                print("Invalid input for Program ID. Please try again.")
                            }
                        } else {
                            print("Invalid College ID. Please choose a valid College ID from the list of colleges.")
                        }
                    } else {
                        print("Invalid input for College ID. Please try again.")
                    }
                } else {
                    print("Invalid input for Course Name. Please try again.")
                }
            } else {
                print("Course with ID \(newCourse_Id) already exists. Please choose a different ID.")
            }
        } else {
            print("Invalid input for Course ID. Please try again.")
        }
    } else {
        print("Invalid input for the index of the Course. Please try again.")
    }
    CourseMenu(category)
}

func deleteCourse(_ category: Course_Category) {
    print("\nEnter the index of the Course to delete:")
    if let input = readLine(), let index = Int(input), index > 0, index <= category.courses.count {
        let course = category.courses[index - 1]
        let oldCourse = course
        category.courses.remove(at: index - 1)
        print("Course deleted successfully!")
        if let indexInMasterList = MasterOrderCourseList.firstIndex(where: { $0.course_Id == oldCourse.course_Id }) {
                                        // Find the index of the old program in the MasterOrderCourseList.
                                        MasterOrderCourseList.remove(at: indexInMasterList)
                                        // remove the course from  MasterOrderCourseList as well.
                                    }
    } else {
        print("Invalid input for the index of the Course. Please try again.")
    }
    CourseMenu(category)
}

func searchBy() {
print("\nSearch by:")
    print("1. Program Name")
    print("2. Course Name")
    print("3. College Name")
    print("4. Course Category Name")
    print("5. Back to Main Menu")
    print("Enter your choice (1/2/3/4/5):")

    if let choice = readLine(), let option = Int(choice) {
        switch option {
        case 1:
            searchByProgram()
        case 2:
            searchByCourse()
        case 3:
            searchByCollege()
        case 4:
            searchByCategory()
        case 5:
            mainMenu()
        default:
            print("Invalid choice. Please try again.")
            searchBy()
        }
    } else {
        print("Invalid input. Please try again.")
        searchBy()
    }

}
func searchByProgram() {
    print("\nEnter the Program Name to search for:")
    if let searchName = readLine(), !searchName.isEmpty {
        var foundPrograms: [Program] = []
        
        for program in MasterOrderProgramsList {
            if program.name.lowercased().contains(searchName.lowercased()) {
                foundPrograms.append(program)
            }
        }
        
        if foundPrograms.isEmpty {
            print("No programs found with the name '\(searchName)'.")
        } else {
            print("Programs found with the name '\(searchName)':")
            for (index, program) in foundPrograms.enumerated() {
                print("\(index + 1). Program ID: \(program.program_Id) Name: \(program.name) College ID: \(program.college_Id)")
            }
        }
    } else {
        print("Invalid input for Program Name. Please try again.")
    }
    searchBy()
}

func searchByCourse() {
    print("\nEnter the Course Name to search for:")
    if let searchName = readLine(), !searchName.isEmpty {
        var foundCourses: [Course] = []
        
        for course in MasterOrderCourseList {
            if course.name.lowercased().contains(searchName.lowercased()) {
                foundCourses.append(course)
            }
        }
        
        if foundCourses.isEmpty {
            print("No courses found with the name '\(searchName)'.")
        } else {
            print("Courses found with the name '\(searchName)':")
            for (index, course) in foundCourses.enumerated() {
                print("\(index + 1). Course ID: \(course.course_Id) Name: \(course.name) College ID: \(course.college_Id) Program ID: \(course.program_Id) Category ID: \(course.category_Id)")
            }
        }
    } else {
        print("Invalid input for Course Name. Please try again.")
    }
    searchBy()
}

func searchByCollege() {
    print("\nEnter the College Name to search for:")
    if let searchName = readLine(), !searchName.isEmpty {
        var foundColleges: [College] = []
        
        for college in colleges {
            if college.name.lowercased().contains(searchName.lowercased()) {
                foundColleges.append(college)
            }
        }
        
        if foundColleges.isEmpty {
            print("No colleges found with the name '\(searchName)'.")
        } else {
            print("Colleges found with the name '\(searchName)':")
            for (index, college) in foundColleges.enumerated() {
                print("\(index + 1). College ID: \(college.college_Id) Name: \(college.name) Address: \(college.address)")
            }
        }
    } else {
        print("Invalid input for college Name. Please try again.")
    }
    searchBy()
}

func searchByCategory() {
    print("\nEnter the Category Name to search for:")
    if let searchName = readLine(), !searchName.isEmpty {
        var foundCategories: [Course_Category] = []
        
        for category in categories {
            if category.name.lowercased().contains(searchName.lowercased()) {
                foundCategories.append(category)
            }
        }
        
        if foundCategories.isEmpty {
            print("No Categories found with the name '\(searchName)'.")
        } else {
            print("Category found with the name '\(searchName)':")
            for (index, category) in foundCategories.enumerated() {
                print("\(index + 1). Category ID: \(category.category_Id) Name: \(category.name)")
                    print("Courses under this Category name: \(category.name)")
                    for course in category.courses {
                    print("Courses: \(course.name)")
                    }
            
            }
        }
    } else {
        print("Invalid input for Course Name. Please try again.")
    }
    searchBy()
}

}

let adminSystem = UniversityAdminSystem()
adminSystem.run()