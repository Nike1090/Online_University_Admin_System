import Foundation

// Struct to represent Course
struct Course {
    var name: String
}

// Struct to represent Program
class Program {
    var name: String
    var courses: [Course] = []

    init(name: String) {
        self.name = name
    }
}

// Class to represent College
class College {
    var name: String
    var programs: [Program] = []

    init(name: String) {
        self.name = name
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
    private var currentUser: AdminUser?

    func run() {
        print("Welcome to the University Admin System!")

        // Create an initial college with some data
        let initialCollege1 = College(name: "COE")
        initialCollege1.programs.append(Program(name: "CS"))
        colleges.append(initialCollege1)
        
        let initialCollege2 = College(name: "COS")
        initialCollege2.programs.append(Program(name: "DA"))
        colleges.append(initialCollege2)

        login()

        if currentUser != nil {
            mainMenu()
        }
    }

    func login() {
        print("\nPlease log in as an admin:")
        print("Enter your email address:")
        if let email = readLine(), email == "admin123@gmail.com" {
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
        print("2. Exit")
        print("Enter your choice (1/2):")

        if let choice = readLine(), let option = Int(choice) {
            switch option {
            case 1:
                manageColleges()
            case 2:
                print("seeya!")
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
            print("\(index + 1). \(college.name)")
        }
        manageColleges()
    }

    func addCollege() {
        print("\nEnter the name of the College to add:")
        if let name = readLine() {
            let newCollege = College(name: name)
            colleges.append(newCollege)
            print("\(name) added successfully!")
        } else {
            print("Invalid input. Please try again.")
        }
        manageColleges()
    }

    func updateCollege() {
        print("\nEnter the index of the College to update:")
        if let input = readLine(), let index = Int(input), index > 0, index <= colleges.count {
            let college = colleges[index - 1]
            print("Enter the new name for \(college.name):")
            if let newName = readLine() {
                college.name = newName
                print("College updated successfully!")
            } else {
                print("Invalid input. Please try again.")
            }
        } else {
            print("Invalid input. Please try again.")
        }
        manageColleges()
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
        print("5. Select a Program")
        print("6. Back to Manage Colleges")
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
                selectProgram(college)
            case 6:
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
            print("\(index + 1). \(program.name)")
        }
        collegeMenu(college)
    }

    func addProgram(_ college: College) {
        print("\nEnter the name of the Program to add:")
        if let name = readLine() {
            let newProgram = Program(name: name)
            college.programs.append(newProgram)
            print("\(name) added successfully to \(college.name)!")
        } else {
            print("Invalid input. Please try again.")
        }
        collegeMenu(college)
    }

    func updateProgram(_ college: College) {
        print("\nEnter the index of the Program to update:")
        if let input = readLine(), let index = Int(input), index > 0, index <= college.programs.count {
            let program = college.programs[index - 1]
            print("Enter the new name for \(program.name):")
            if let newName = readLine() {
                program.name = newName
                print("Program updated successfully!")
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
            if program.courses.isEmpty {
                college.programs.remove(at: index - 1)
                print("Program deleted successfully!")
            } else {
                print("Cannot delete a program with courses. Please delete the courses first.")
            }
        } else {
            print("Invalid input. Please try again.")
        }
        collegeMenu(college)
    }

    func selectProgram(_ college: College) {
        print("\nEnter the index of the Program to select:")
        if let input = readLine(), let index = Int(input), index > 0, index <= college.programs.count {
            let program = college.programs[index - 1]
            print("Selected Program: \(program.name)")
            programMenu(program)
        } else {
            print("Invalid input. Please try again.")
            collegeMenu(college)
        }
    }

    func programMenu(_ program: Program) {
        print("\nProgram Menu for \(program.name):")
        print("1. Display All Courses")
        print("2. Add a Course")
        print("3. Update a Course")
        print("4. Delete a Course")
        print("5. Back to Select a Program")
        print("Enter your choice (1/2/3/4/5):")

        if let choice = readLine(), let option = Int(choice) {
            switch option {
            case 1:
                displayAllCourses(program)
            case 2:
                addCourse(program)
            case 3:
                updateCourse(program)
            case 4:
                deleteCourse(program)
            case 5:
                selectProgram(colleges[0])
            default:
                print("Invalid choice. Please try again.")
                programMenu(program)
            }
        } else {
            print("Invalid input. Please try again.")
            programMenu(program)
        }
    }

    func displayAllCourses(_ program: Program) {
        print("\nAll Courses in \(program.name):")
        for (index, course) in program.courses.enumerated() {
            print("\(index + 1). \(course.name)")
        }
        programMenu(program)
    }

    func addCourse(_ program: Program) {
    print("\nEnter the name of the Course to add:")
    if let name = readLine() {
        let newCourse = Course(name: name)
        program.courses.append(newCourse)
        print("\(name) added successfully to \(program.name)!")
    } else {
        print("Invalid input. Please try again.")
    }
    programMenu(program)
}


    func updateCourse(_ program: Program) {
        print("\nEnter the index of the Course to update:")
        if let input = readLine(), let index = Int(input), index > 0, index <= program.courses.count {
             let courseIndex = index - 1
            print("Enter the new name for \(program.courses[courseIndex].name):")
            if let newName = readLine() {
                program.courses[courseIndex].name = newName
                print("Course updated successfully!")
            } else {
                print("Invalid input. Please try again.")
            }
        } else {
            print("Invalid input. Please try again.")
        }
        programMenu(program)
    }

    func deleteCourse(_ program: Program) {
        print("\nEnter the index of the Course to delete:")
        if let input = readLine(), let index = Int(input), index > 0, index <= program.courses.count {
            program.courses.remove(at: index - 1)
            print("Course deleted successfully!")
        } else {
            print("Invalid input. Please try again.")
        }
        programMenu(program)
    }
}

let adminSystem = UniversityAdminSystem()
adminSystem.run()
