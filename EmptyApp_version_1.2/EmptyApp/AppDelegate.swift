//
// AppDelegate.swift
// EmptyApp
//
// Created by rab on 02/15/21.
// Copyright © 2021 rab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var currentUser: AdminUser?
    private var usernameField: UITextField?
    private var passwordField: UITextField?
    private var colleges: [College] = []
    private var categories: [Course_Category] = []
    private var MasterOrderProgramsList: [Program] = []
    private var MasterOrderCourseList: [Course] = []
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
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
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.backgroundColor = UIColor.lightGray
            window.rootViewController = UIViewController()
            window.makeKeyAndVisible()
            
            
            let rect:CGRect = CGRect(x:125,y:280,width:130,height:50)
            let label:UILabel = UILabel(frame: rect)
            label.text=" Login"
            label.textAlignment = .center
            let fontSize: CGFloat = 35.0
            label.font = UIFont.systemFont(ofSize: fontSize)
            window.addSubview(label)
            
            
            let textLoginFields = createLoginTextFields()
            usernameField = textLoginFields.0
            passwordField = textLoginFields.1
            window.addSubview(usernameField!)
            window.addSubview(passwordField!)
            
            let loginButton = UIButton(frame: CGRect(x: 75, y: 480, width: 250, height: 50))
            loginButton.setTitle("Login", for: .normal)
            loginButton.backgroundColor = UIColor.systemBlue
            loginButton.layer.cornerRadius = 10
            loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
            window.addSubview(loginButton)
            
        }
        
        return true
    }
    
    @objc func login() {
        // Get the text from the username and password text fields
        let username = usernameField?.text
        let password = passwordField?.text
        
        currentUser = AdminUser(email: "1", password: "1")
        
        // Check the username and password for login
        if username == currentUser?.email && password == currentUser?.password {
            // Successful login, create a new view
            let homeView = UIView(frame: (window?.bounds)!)
            homeView.backgroundColor = UIColor.lightGray
            homeView.tag = 1
            window?.addSubview(homeView)
            
            let ManageColleges = UIButton(frame: CGRect(x: 75, y: 320, width: 250, height: 50))
            ManageColleges.setTitle("Manage Colleges", for: .normal)
            ManageColleges.backgroundColor = UIColor.systemBlue
            ManageColleges.layer.cornerRadius = 10
            ManageColleges.addTarget(self, action: #selector(manageColleges(sender:)), for: .touchUpInside)
            homeView.addSubview(ManageColleges)
            
            let ManageCC = UIButton(frame: CGRect(x: 75, y: 380, width: 250, height: 50))
            ManageCC.setTitle("Manage Course Category", for: .normal)
            ManageCC.backgroundColor = UIColor.systemBlue
            ManageCC.layer.cornerRadius = 10
            ManageCC.addTarget(self, action: #selector(manageCC), for: .touchUpInside)
            homeView.addSubview(ManageCC)
            
            let searchBy = UIButton(frame: CGRect(x: 75, y: 440, width: 250, height: 50))
            searchBy.setTitle("Search by", for: .normal)
            searchBy.backgroundColor = UIColor.systemBlue
            searchBy.layer.cornerRadius = 10
            searchBy.addTarget(self, action: #selector(searchIt), for: .touchUpInside)
            homeView.addSubview(searchBy)
            
            let logOut = UIButton(frame: CGRect(x: 75, y: 500, width: 250, height: 50))
            logOut.setTitle("Log out", for: .normal)
            logOut.backgroundColor = UIColor.systemBlue
            logOut.layer.cornerRadius = 10
            logOut.addTarget(self, action: #selector(closeView(sender:)), for: .touchUpInside)
            homeView.addSubview(logOut)
            
            
        } else {
            // Incorrect creds, show an error message popup
            let errorRect: CGRect = CGRect(x: 75, y: 350, width: 250, height: 200)
            let errorView = UIView(frame: errorRect)
            errorView.backgroundColor = UIColor.darkGray
            errorView.layer.cornerRadius = 20 // Round the corners
            
            let errorMessage = UILabel(frame: errorView.bounds)
            errorMessage.text = "Login failed. Incorrect username or password"
            errorMessage.textAlignment = .center
            errorMessage.textColor = UIColor.red
            errorView.addSubview(errorMessage)
            
            let closeButton = UIButton(type: .custom)
            closeButton.frame = CGRect(x: errorView.frame.width - 30, y: 5, width: 25, height: 25)
            closeButton.setTitle("X", for: .normal)
            closeButton.setTitleColor(UIColor.white, for: .normal)
            closeButton.addTarget(self, action: #selector(closeView(sender:)), for: .touchUpInside)
            errorView.addSubview(closeButton)
            
            // Add the error view to the window with alpha set to 0 for the initial animation
            errorView.alpha = 0
            window?.addSubview(errorView)
            
            // Animate the appearance of the error view
            UIView.animate(withDuration: 0.3) {
                errorView.alpha = 1
            }
        }
    }
    
    
    @objc func manageColleges(sender: UIButton) {
        
        
        if let homeView = window?.viewWithTag(1) {
            let manageCollegesView = UIView(frame: homeView.bounds)
            manageCollegesView.backgroundColor = UIColor.lightGray
            manageCollegesView.tag = 2
            homeView.addSubview(manageCollegesView)
            
            //Add College button
            let addCollege = UIButton(frame: CGRect(x: 75, y: 280, width: 250, height: 50))
            addCollege.setTitle("Add Colleges", for: .normal)
            addCollege.backgroundColor = UIColor.systemBlue
            addCollege.layer.cornerRadius = 10
            addCollege.addTarget(self, action: #selector(addClg(sender:)), for: .touchUpInside)
            manageCollegesView.addSubview(addCollege)
            //Update College button
            let updCollege = UIButton(frame: CGRect(x: 75, y: 340, width: 250, height: 50))
            updCollege.setTitle("Update Colleges", for: .normal)
            updCollege.backgroundColor = UIColor.systemBlue
            updCollege.layer.cornerRadius = 10
            updCollege.addTarget(self, action: #selector(updClg(sender:)), for: .touchUpInside)
            manageCollegesView.addSubview(updCollege)
            //Delete college
            let delCollege = UIButton(frame: CGRect(x: 75, y: 400, width: 250, height: 50))
            delCollege.setTitle("Delete Colleges", for: .normal)
            delCollege.backgroundColor = UIColor.systemBlue
            delCollege.layer.cornerRadius = 10
            delCollege.addTarget(self, action: #selector(delClg(sender:)), for: .touchUpInside)
            manageCollegesView.addSubview(delCollege)
            //Display Colleges
            let displayColleges = UIButton(frame: CGRect(x: 75, y: 460, width: 250, height: 50))
            displayColleges.setTitle("Display Colleges", for: .normal)
            displayColleges.backgroundColor = UIColor.systemBlue
            displayColleges.layer.cornerRadius = 10
            displayColleges.addTarget(self, action: #selector(dispClg(sender:)), for: .touchUpInside)
            manageCollegesView.addSubview(displayColleges)
            //Select Colleges
            let clgIdField = createSelectField()
            manageCollegesView.addSubview(clgIdField)
            let selectColleges = UIButton(frame: CGRect(x: 75, y: 520, width: 250, height: 50))
            selectColleges.setTitle("Select Colleges", for: .normal)
            selectColleges.backgroundColor = UIColor.systemBlue
            selectColleges.layer.cornerRadius = 10
            selectColleges.addTarget(self, action: #selector(selectClg(sender:)), for: .touchUpInside)
            manageCollegesView.addSubview(selectColleges)
            //Back to Main Menu
            let bckToMainMenu = UIButton(frame: CGRect(x: 75, y: 580, width: 250, height: 50))
            bckToMainMenu.setTitle("Back to Menu", for: .normal)
            bckToMainMenu.backgroundColor = UIColor.systemBlue
            bckToMainMenu.layer.cornerRadius = 10
            bckToMainMenu.addTarget(self, action: #selector(switchToMainMenu(sender:)), for: .touchUpInside)
            manageCollegesView.addSubview(bckToMainMenu)
            
            
        }
        
    }
    
    
    @objc func manageCC(sender: UIButton) {
        if let homeView = window?.viewWithTag(1) {
            let manageCCView = UIView(frame: homeView.bounds)
            manageCCView.backgroundColor = UIColor.lightGray
            manageCCView.tag = 3
            homeView.addSubview(manageCCView)
            
            // Add Course Category button
            let addCategory = UIButton(frame: CGRect(x: 75, y: 280, width: 250, height: 50))
            addCategory.setTitle("Add Course Category", for: .normal)
            addCategory.backgroundColor = UIColor.systemBlue
            addCategory.layer.cornerRadius = 10
            addCategory.addTarget(self, action: #selector(addCategory(sender:)), for: .touchUpInside)
            manageCCView.addSubview(addCategory)
            
            // Update Course Category button
            let updateCategory = UIButton(frame: CGRect(x: 75, y: 340, width: 250, height: 50))
            updateCategory.setTitle("Update Course Category", for: .normal)
            updateCategory.backgroundColor = UIColor.systemBlue
            updateCategory.layer.cornerRadius = 10
            updateCategory.addTarget(self, action: #selector(updateCategory(sender:)), for: .touchUpInside)
            manageCCView.addSubview(updateCategory)
            
            // Delete Course Category button
            let deleteCategory = UIButton(frame: CGRect(x: 75, y: 400, width: 250, height: 50))
            deleteCategory.setTitle("Delete Course Category", for: .normal)
            deleteCategory.backgroundColor = UIColor.systemBlue
            deleteCategory.layer.cornerRadius = 10
            deleteCategory.addTarget(self, action: #selector(deleteCategory(sender:)), for: .touchUpInside)
            manageCCView.addSubview(deleteCategory)
            
            // Display Course Categories button
            let displayCategories = UIButton(frame: CGRect(x: 75, y: 460, width: 250, height: 50))
            displayCategories.setTitle("Display Course Categories", for: .normal)
            displayCategories.backgroundColor = UIColor.systemBlue
            displayCategories.layer.cornerRadius = 10
            displayCategories.addTarget(self, action: #selector(displayCategories(sender:)), for: .touchUpInside)
            manageCCView.addSubview(displayCategories)
            
            // Select Course Category
            let categoryIdField = createSelectCatField()
            manageCCView.addSubview(categoryIdField)
            let selectCategory = UIButton(frame: CGRect(x: 75, y: 520, width: 250, height: 50))
            selectCategory.setTitle("Select Course Category", for: .normal)
            selectCategory.backgroundColor = UIColor.systemBlue
            selectCategory.layer.cornerRadius = 10
            selectCategory.addTarget(self, action: #selector(selectCategory(sender:)), for: .touchUpInside)
            manageCCView.addSubview(selectCategory)
            
            // Back to Main Menu
            let backToMainMenu = UIButton(frame: CGRect(x: 75, y: 580, width: 250, height: 50))
            backToMainMenu.setTitle("Back to Menu", for: .normal)
            backToMainMenu.backgroundColor = UIColor.systemBlue
            backToMainMenu.layer.cornerRadius = 10
            backToMainMenu.addTarget(self, action: #selector(switchToMainMenu(sender:)), for: .touchUpInside)
            manageCCView.addSubview(backToMainMenu)
        }
    }

    
    @objc func searchIt() {
        
        if let homeView = window?.viewWithTag(1) {
            let searchItView = UIView(frame: homeView.bounds)
            searchItView.backgroundColor = UIColor.lightGray
            searchItView.tag = 4
            homeView.addSubview(searchItView)
            
            //by College button
            let byCollege = UIButton(frame: CGRect(x: 210, y: 70, width: 150, height: 30))
            byCollege.setTitle("Serach College ", for: .normal)
            byCollege.backgroundColor = UIColor.systemBlue
            byCollege.layer.cornerRadius = 10
            byCollege.addTarget(self, action: #selector(searchClgs(sender:)), for: .touchUpInside)
            searchItView.addSubview(byCollege)
            //by Program button
            let byProgram = UIButton(frame: CGRect(x: 210, y: 110, width: 150, height: 30))
            byProgram.setTitle("Search Program", for: .normal)
            byProgram.backgroundColor = UIColor.systemBlue
            byProgram.layer.cornerRadius = 10
            byProgram.addTarget(self, action: #selector(searchPros(sender:)), for: .touchUpInside)
            searchItView.addSubview(byProgram)
            //by Course
            let byCourse = UIButton(frame: CGRect(x: 210, y: 150, width: 150, height: 30))
            byCourse.setTitle("Search Course", for: .normal)
            byCourse.backgroundColor = UIColor.systemBlue
            byCourse.layer.cornerRadius = 10
            byCourse.addTarget(self, action: #selector(searchCrs(sender:)), for: .touchUpInside)
            searchItView.addSubview(byCourse)
            //by course category
            let byCC = UIButton(frame: CGRect(x: 210, y: 190, width: 150, height: 30))
            byCC.setTitle("Search Category", for: .normal)
            byCC.backgroundColor = UIColor.systemBlue
            byCC.layer.cornerRadius = 10
            byCC.addTarget(self, action: #selector(searchCats(sender:)), for: .touchUpInside)
            searchItView.addSubview(byCC)
            //search Colleges
            let searchFields = createSearchTextFields()
            let searchclg = searchFields.0
            let serachPro = searchFields.1
            let searchCrs = searchFields.2
            let searchCC = searchFields.3
           
            searchItView.addSubview(searchclg)
            searchItView.addSubview(serachPro)
            searchItView.addSubview(searchCrs)
            searchItView.addSubview(searchCC)

            let InfoLabel = UILabel(frame: CGRect(x: 40, y: 220, width: 300, height: 400 ))
            InfoLabel.numberOfLines = 0 // Allow multiple lines
            InfoLabel.textAlignment = .center
            InfoLabel.textColor = UIColor.black
            
            
            searchItView.addSubview(InfoLabel)
            
            //Back to Main Menu
            let bckToMainMenu = UIButton(frame: CGRect(x: 75, y: 650, width: 250, height: 50))
            bckToMainMenu.setTitle("Back to Menu", for: .normal)
            bckToMainMenu.backgroundColor = UIColor.systemBlue
            bckToMainMenu.layer.cornerRadius = 10
            bckToMainMenu.addTarget(self, action: #selector(switchToMainMenu(sender:)), for: .touchUpInside)
            searchItView.addSubview(bckToMainMenu)
            
            
        }
        
    }
    
    @objc func addClg(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2) {
            let addClgView = UIView(frame: manageCollegesView.bounds)
            addClgView.backgroundColor = UIColor.lightGray
            addClgView.tag = 50
            manageCollegesView.addSubview(addClgView)
            
            let textAddClgfields = createAddClgTextFields()
            let clgId = textAddClgfields.0
            let clgName = textAddClgfields.1
            let clgAddress = textAddClgfields.2
            addClgView.addSubview(clgId)
            addClgView.addSubview(clgName)
            addClgView.addSubview(clgAddress)
            
            let AddCollegeBtn = UIButton(frame: CGRect(x: 75, y: 530, width: 250, height: 50))
            AddCollegeBtn.setTitle("Add College", for: .normal)
            AddCollegeBtn.backgroundColor = UIColor.systemBlue
            AddCollegeBtn.layer.cornerRadius = 10
            AddCollegeBtn.addTarget(self, action: #selector(addCollege), for: .touchUpInside) // Update the action
            addClgView.addSubview(AddCollegeBtn)
            
            // Add a message label to display status messages
            let messageLabel = UILabel(frame: CGRect(x: 75, y: 300, width: 250, height: 40))
            messageLabel.textAlignment = .center
            addClgView.addSubview(messageLabel)
            
            // Set the tag for the message label to easily update its text
            messageLabel.tag = 51
            
            let bckBtnMngclg = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            bckBtnMngclg.setTitle("Back to Manage colleges", for: .normal)
            bckBtnMngclg.backgroundColor = UIColor.systemBlue
            bckBtnMngclg.layer.cornerRadius = 10
            bckBtnMngclg.addTarget(self, action: #selector(switchtoMngColleges(sender:)), for: .touchUpInside) // Update the action
            addClgView.addSubview(bckBtnMngclg)
        }
    }
    
    @objc func addCollege(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2) {
            if let addClgView = manageCollegesView.viewWithTag(50) {
                if let clgIdField = addClgView.viewWithTag(0) as? UITextField,
                   let clgNameField = addClgView.viewWithTag(1) as? UITextField,
                   let clgAddressField = addClgView.viewWithTag(2) as? UITextField,
                   let messageLabel = addClgView.viewWithTag(51) as? UILabel {
                    
                    // Check if all fields are filled
                    if !clgIdField.text!.isEmpty && !clgNameField.text!.isEmpty && !clgAddressField.text!.isEmpty {
                        if let clgId = Int(clgIdField.text ?? "") {
                            if !colleges.contains(where: { $0.college_Id == clgId }) {
                                let name = clgNameField.text!
                                let address = clgAddressField.text!
                                let newCollege = College(college_Id: clgId, name: name, address: address)
                                colleges.append(newCollege)
                                messageLabel.text = "\(name) added successfully!"
                            } else {
                                messageLabel.text = "College with ID \(clgIdField.text ?? "") already exists. Please choose a different ID."
                            }
                        } else {
                            messageLabel.text = "Invalid input. Please enter a valid integer for College ID."
                        }
                    } else {
                        messageLabel.text = "Fill all fields."
                    }
                }
            }
        }
    }
    
    @objc func updClg(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2) {
            let updClgView = UIView(frame: manageCollegesView.bounds)
            updClgView.backgroundColor = UIColor.lightGray
            updClgView.tag = 52
            manageCollegesView.addSubview(updClgView)
            
            let textFields = createUpdClgTextFields()
            let clgIdField = textFields.0
            let clgNameField = textFields.1
            let clgAddressField = textFields.2
            
            updClgView.addSubview(clgIdField)
            updClgView.addSubview(clgNameField)
            updClgView.addSubview(clgAddressField)
            
            let fetchCollegeBtn = UIButton(frame: CGRect(x: 75, y: 530, width: 250, height: 50))
            fetchCollegeBtn.setTitle("Fetch College", for: .normal)
            fetchCollegeBtn.backgroundColor = UIColor.systemBlue
            fetchCollegeBtn.layer.cornerRadius = 10
            fetchCollegeBtn.addTarget(self, action: #selector(fetchCollege), for: .touchUpInside)
            updClgView.addSubview(fetchCollegeBtn)
            
            // Add a message label to display status messages
            let messageLabel = UILabel(frame: CGRect(x: 75, y: 590, width: 250, height: 40))
            messageLabel.textAlignment = .center
            messageLabel.tag = 53
            updClgView.addSubview(messageLabel)
            
            let updateCollegeBtn = UIButton(frame: CGRect(x: 75, y: 640, width: 250, height: 50))
            updateCollegeBtn.setTitle("Update College", for: .normal)
            updateCollegeBtn.backgroundColor = UIColor.systemBlue
            updateCollegeBtn.layer.cornerRadius = 10
            updateCollegeBtn.addTarget(self, action: #selector(updateCollege), for: .touchUpInside)
            updClgView.addSubview(updateCollegeBtn)
            
            let bckBtnMngclg = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            bckBtnMngclg.setTitle("Back to Manage colleges", for: .normal)
            bckBtnMngclg.backgroundColor = UIColor.systemBlue
            bckBtnMngclg.layer.cornerRadius = 10
            bckBtnMngclg.addTarget(self, action: #selector(switchtoMngColleges(sender:)), for: .touchUpInside) // Update the action
            updClgView.addSubview(bckBtnMngclg)
        }
    }
    
    @objc func fetchCollege(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2) {
            if let updClgView = manageCollegesView.viewWithTag(52) {
                if let clgIdField = updClgView.subviews.first(where: { $0 is UITextField && $0.tag == 0 }) as? UITextField,
                   let clgNameField = updClgView.subviews.first(where: { $0 is UITextField && $0.tag == 1 }) as? UITextField,
                   let clgAddressField = updClgView.subviews.first(where: { $0 is UITextField && $0.tag == 2 }) as? UITextField,
                   let messageLabel = updClgView.viewWithTag(53) as? UILabel {
                    
                    if let clgId = Int(clgIdField.text ?? "") {
                        if let college = colleges.first(where: { $0.college_Id == clgId }) {
                            clgNameField.text = college.name
                            clgAddressField.text = college.address
                            messageLabel.text = "College found. You can update its details."
                        } else {
                            messageLabel.text = "College with ID \(clgId) not found."
                        }
                    } else {
                        messageLabel.text = "Invalid input. Please enter a valid integer for College ID."
                    }
                }
            }
        }
    }
    
    @objc func updateCollege(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2) {
            if let updClgView = manageCollegesView.viewWithTag(52) {
                if let clgIdField = updClgView.subviews.first(where: { $0 is UITextField && $0.tag == 0 }) as? UITextField,
                   let clgNameField = updClgView.subviews.first(where: { $0 is UITextField && $0.tag == 1 }) as? UITextField,
                   let clgAddressField = updClgView.subviews.first(where: { $0 is UITextField && $0.tag == 2 }) as? UITextField,
                   let messageLabel = updClgView.viewWithTag(53) as? UILabel {
                    
                    if let clgId = Int(clgIdField.text ?? ""), let index = colleges.firstIndex(where: { $0.college_Id == clgId }) {
                        if !clgNameField.text!.isEmpty && !clgAddressField.text!.isEmpty {
                            let name = clgNameField.text!
                            let address = clgAddressField.text!
                            colleges[index].name = name
                            colleges[index].address = address
                            messageLabel.text = "College updated successfully!"
                        } else {
                            messageLabel.text = "Fill all fields."
                        }
                    } else {
                        messageLabel.text = "Invalid input. College with the given ID does not exist."
                    }
                }
            }
        }
    }
    
    @objc func delClg(sender: UIButton){
        if let manageCollegesView = window?.viewWithTag(2) {
            let delClgView = UIView(frame: manageCollegesView.bounds)
            delClgView.backgroundColor = UIColor.lightGray
            delClgView.tag = 54
            manageCollegesView.addSubview(delClgView)
            
            
            let ClgIdField = UITextField(frame: CGRect(x: 75.0, y: 350.0, width: 250.0, height: 50.0))
            ClgIdField.textAlignment = NSTextAlignment.center
            ClgIdField.textColor = UIColor.black
            ClgIdField.backgroundColor = UIColor.white
            ClgIdField.borderStyle = UITextField.BorderStyle.roundedRect
            ClgIdField.clearButtonMode = .whileEditing
            ClgIdField.placeholder = "Enter Collge Id to delete"
            ClgIdField.keyboardType = .default
            ClgIdField.returnKeyType = .done
            
            delClgView.addSubview(ClgIdField)
            
            let delClgbtn = UIButton(frame: CGRect(x: 75, y: 410, width: 250, height: 50))
            delClgbtn.setTitle("Delete College", for: .normal)
            delClgbtn.backgroundColor = UIColor.systemBlue
            delClgbtn.layer.cornerRadius = 10
            delClgbtn.addTarget(self, action: #selector(deleteCollege), for: .touchUpInside)
            delClgView.addSubview(delClgbtn)
            
            let messageLabel = UILabel(frame: CGRect(x: 75, y: 300, width: 250, height: 40))
            messageLabel.textAlignment = .center
            messageLabel.tag = 55
            delClgView.addSubview(messageLabel)
            
            
            let bckBtnMngclg = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            bckBtnMngclg.setTitle("Back to Manage colleges", for: .normal)
            bckBtnMngclg.backgroundColor = UIColor.systemBlue
            bckBtnMngclg.layer.cornerRadius = 10
            bckBtnMngclg.addTarget(self, action: #selector(switchtoMngColleges(sender:)), for: .touchUpInside) // Update the action
            delClgView.addSubview(bckBtnMngclg)
        }
    }
    
    @objc func deleteCollege(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2) {
            if let delClgView = manageCollegesView.viewWithTag(54) {
                if let clgIdField = delClgView.subviews.first(where: { $0 is UITextField && $0.tag == 0 }) as? UITextField,
                   let messageLabel = delClgView.viewWithTag(55) as? UILabel {
                    
                    if let clgId = Int(clgIdField.text ?? "") {
                        if let index = colleges.firstIndex(where: { $0.college_Id == clgId }) {
                            let college = colleges[index]
                            if college.programs.isEmpty {
                                colleges.remove(at: index)
                                messageLabel.text = "College deleted successfully!"
                            } else {
                                messageLabel.text = "Cannot delete a college with programs. Please delete the programs first."
                            }
                        } else {
                            messageLabel.text = "College with ID \(clgId) not found."
                        }
                    } else {
                        messageLabel.text = "Invalid input. Please enter a valid integer for College ID."
                    }
                }
            }
        }
    }
    
    @objc func dispClg(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2) {
            let dispClgView = UIView(frame: manageCollegesView.bounds)
            dispClgView.backgroundColor = UIColor.lightGray
            dispClgView.tag = 56
            manageCollegesView.addSubview(dispClgView)
            
            // Add a label to display college information
            let collegeInfoLabel = UILabel(frame: CGRect(x: 10, y: 10, width: dispClgView.frame.width - 20, height: dispClgView.frame.height - 70))
            collegeInfoLabel.numberOfLines = 0 // Allow multiple lines
            collegeInfoLabel.textAlignment = .left
            collegeInfoLabel.textColor = UIColor.black
            collegeInfoLabel.text = "Colleges Information:\n"
            
            // Append college information to the label
            for (index, college) in colleges.enumerated() {
                collegeInfoLabel.text?.append("\n\(index + 1). College ID: \(college.college_Id)\nName: \(college.name)\nAddress: \(college.address)\n")
            }
            
            dispClgView.addSubview(collegeInfoLabel)
            
            let bckBtnMngclg = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            bckBtnMngclg.setTitle("Back to Manage colleges", for: .normal)
            bckBtnMngclg.backgroundColor = UIColor.systemBlue
            bckBtnMngclg.layer.cornerRadius = 10
            bckBtnMngclg.addTarget(self, action: #selector(switchtoMngColleges(sender:)), for: .touchUpInside)
            dispClgView.addSubview(bckBtnMngclg)
        }
    }
    
    @objc func selectClg(sender: UIButton) {
        
        if let manageCollegesView = window?.viewWithTag(2) {
                if let clgIdField = manageCollegesView.viewWithTag(4) as? UITextField {
                    if let clgIdText = clgIdField.text, let clgId = Int(clgIdText),  let college = colleges.first(where: { $0.college_Id == clgId }) {
                        print("\(clgIdText)")
                
                // Pass the selected college to the view
                let selectClgView = UIView(frame: manageCollegesView.bounds)
                selectClgView.backgroundColor = UIColor.lightGray
                selectClgView.tag = 57
                manageCollegesView.addSubview(selectClgView)
                
                // Add buttons for managing the selected college
                let addProgramBtn = UIButton(frame: CGRect(x: 75, y: 100, width: 250, height: 50))
                addProgramBtn.setTitle("Add Program", for: .normal)
                addProgramBtn.backgroundColor = UIColor.systemBlue
                addProgramBtn.layer.cornerRadius = 10
                addProgramBtn.addTarget(self, action: #selector(addProgramView(sender:)), for: .touchUpInside)
                selectClgView.addSubview(addProgramBtn)
                
                let updateProgramBtn = UIButton(frame: CGRect(x: 75, y: 160, width: 250, height: 50))
                updateProgramBtn.setTitle("Update Program", for: .normal)
                updateProgramBtn.backgroundColor = UIColor.systemBlue
                updateProgramBtn.layer.cornerRadius = 10
                updateProgramBtn.addTarget(self, action: #selector(updateProgramView(sender:)), for: .touchUpInside)
                selectClgView.addSubview(updateProgramBtn)
                
                let deleteProgramBtn = UIButton(frame: CGRect(x: 75, y: 220, width: 250, height: 50))
                deleteProgramBtn.setTitle("Delete Program", for: .normal)
                deleteProgramBtn.backgroundColor = UIColor.systemBlue
                deleteProgramBtn.layer.cornerRadius = 10
                deleteProgramBtn.addTarget(self, action: #selector(deleteProgramView(sender:)), for: .touchUpInside)
                selectClgView.addSubview(deleteProgramBtn)
                
                let displayProgramsBtn = UIButton(frame: CGRect(x: 75, y: 280, width: 250, height: 50))
                displayProgramsBtn.setTitle("Display Programs", for: .normal)
                displayProgramsBtn.backgroundColor = UIColor.systemBlue
                displayProgramsBtn.layer.cornerRadius = 10
                displayProgramsBtn.addTarget(self, action: #selector(displayProgramsView(sender:)), for: .touchUpInside)
                selectClgView.addSubview(displayProgramsBtn)
                
                let backToCollegesBtn = UIButton(frame: CGRect(x: 75, y: 340, width: 250, height: 50))
                backToCollegesBtn.setTitle("Back to Colleges", for: .normal)
                backToCollegesBtn.backgroundColor = UIColor.systemBlue
                backToCollegesBtn.layer.cornerRadius = 10
                backToCollegesBtn.addTarget(self, action: #selector(switchToColleges(sender:)), for: .touchUpInside)
                selectClgView.addSubview(backToCollegesBtn)
                
            } else {
                let notFoundLabel = UILabel(frame: CGRect(x: 75, y: 100, width: 250, height: 40))
                notFoundLabel.textAlignment = .center
                notFoundLabel.text = "College with ID \(clgIdField.text ?? "") does not exist."
                manageCollegesView.addSubview(notFoundLabel)
            }
        }
    }
}

    @objc func addProgramView(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2),
            let selectClgView = manageCollegesView.viewWithTag(57) {
            
            let addProgramView = UIView(frame: selectClgView.bounds)
            addProgramView.backgroundColor = UIColor.lightGray
            addProgramView.tag = 58
            selectClgView.addSubview(addProgramView)
            
            let textAddProFields = createAddProTextFields()
            let proIdField = textAddProFields.0
            let proNameField = textAddProFields.1
            let clgIdField = textAddProFields.2
            
            proIdField.tag = 5 // Set tag for proIdField
            proNameField.tag = 6 // Set tag for proNameField
            clgIdField.tag = 7 // Set tag for clgIdField
            
            addProgramView.addSubview(proIdField)
            addProgramView.addSubview(proNameField)
            addProgramView.addSubview(clgIdField)
            
            let addProgramBtn = UIButton(frame: CGRect(x: 75, y: 530, width: 250, height: 50))
            addProgramBtn.setTitle("Add Program", for: .normal)
            addProgramBtn.backgroundColor = UIColor.systemBlue
            addProgramBtn.layer.cornerRadius = 10
            addProgramBtn.addTarget(self, action: #selector(addProgramToCollege), for: .touchUpInside)
            addProgramView.addSubview(addProgramBtn)
            
            // Add a message label to display status messages
            let messageLabel = UILabel(frame: CGRect(x: 75, y: 300, width: 250, height: 40))
            messageLabel.textAlignment = .center
            addProgramView.addSubview(messageLabel)
            
            // Set the tag for the message label to easily update its text
            messageLabel.tag = 59
            
            let backToCollegesBtn = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            backToCollegesBtn.setTitle("Back to Manage Programs", for: .normal)
            backToCollegesBtn.backgroundColor = UIColor.systemBlue
            backToCollegesBtn.layer.cornerRadius = 10
            backToCollegesBtn.addTarget(self, action: #selector(switchToColleges(sender:)), for: .touchUpInside)
            addProgramView.addSubview(backToCollegesBtn)
        }
    }

    @objc func addProgramToCollege(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2),
            let selectClgView = manageCollegesView.viewWithTag(57) {
            
            if let proIdField = selectClgView.viewWithTag(5) as? UITextField,
               let proNameField = selectClgView.viewWithTag(6) as? UITextField,
               let clgIdField = selectClgView.viewWithTag(7) as? UITextField,
               let messageLabel = selectClgView.viewWithTag(59) as? UILabel,
               let proIdText = proIdField.text, !proIdText.isEmpty,
               let proId = Int(proIdText),
               let proName = proNameField.text, !proName.isEmpty,
               let clgIdText = clgIdField.text, !clgIdText.isEmpty,
               let clgId = Int(clgIdText) {
                
                // Check if the selected college ID exists
                if let college = colleges.first(where: { $0.college_Id == clgId }) {
                    
                    // Check if the program ID is unique in the selected college
                    if !college.programs.contains(where: { $0.program_Id == proId }) {
                        // Set the college_Id of the newProgram to the selected college's ID
                        let newProgram = Program(program_Id: proId, name: proName, college_Id: college.college_Id)
                        college.programs.append(newProgram)
                        MasterOrderProgramsList.append(newProgram)
                        messageLabel.text = "\(proName) added to \(college.name) successfully!"
                    } else {
                        messageLabel.text = "Program with ID \(proId) already exists in \(college.name). Please choose a different ID."
                    }
                } else {
                    messageLabel.text = "Selected college does not exist."
                }
            }
        }
    }


    @objc func updateProgramView(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2) {
            let updateProgramView = UIView(frame: manageCollegesView.bounds)
            updateProgramView.backgroundColor = UIColor.lightGray
            updateProgramView.tag = 60
            manageCollegesView.addSubview(updateProgramView)
            
            let textFields = createUpdProTextFields()
            let programIdField = textFields.0
            let programNameField = textFields.1
            let clgIdField = textFields.2
            
            updateProgramView.addSubview(programIdField)
            updateProgramView.addSubview(programNameField)
            updateProgramView.addSubview(clgIdField)
            
            let fetchProgramBtn = UIButton(frame: CGRect(x: 75, y: 530, width: 250, height: 50))
            fetchProgramBtn.setTitle("Fetch Program", for: .normal)
            fetchProgramBtn.backgroundColor = UIColor.systemBlue
            fetchProgramBtn.layer.cornerRadius = 10
            fetchProgramBtn.addTarget(self, action: #selector(fetchProgram), for: .touchUpInside)
            updateProgramView.addSubview(fetchProgramBtn)
            
            let messageLabel = UILabel(frame: CGRect(x: 75, y: 590, width: 250, height: 40))
            messageLabel.textAlignment = .center
            messageLabel.tag = 61
            updateProgramView.addSubview(messageLabel)
            
            let updateProgramBtn = UIButton(frame: CGRect(x: 75, y: 640, width: 250, height: 50))
            updateProgramBtn.setTitle("Update Program", for: .normal)
            updateProgramBtn.backgroundColor = UIColor.systemBlue
            updateProgramBtn.layer.cornerRadius = 10
            updateProgramBtn.addTarget(self, action: #selector(updateProgram), for: .touchUpInside)
            updateProgramView.addSubview(updateProgramBtn)
            
            let backToManageCollegesBtn = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            backToManageCollegesBtn.setTitle("Back to Manage Programs", for: .normal)
            backToManageCollegesBtn.backgroundColor = UIColor.systemBlue
            backToManageCollegesBtn.layer.cornerRadius = 10
            backToManageCollegesBtn.addTarget(self, action: #selector(switchToColleges), for: .touchUpInside)
            updateProgramView.addSubview(backToManageCollegesBtn)
        }
    }

    @objc func fetchProgram(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2) {
            if let updateProgramView = manageCollegesView.viewWithTag(60) {
                if let programIdField = updateProgramView.subviews.first(where: { $0 is UITextField && $0.tag == 8 }) as? UITextField,
                   let programNameField = updateProgramView.subviews.first(where: { $0 is UITextField && $0.tag == 9 }) as? UITextField,
                   let messageLabel = updateProgramView.viewWithTag(61) as? UILabel {
                    
                    if let programId = Int(programIdField.text ?? "") {
                        // Find the program by ID in your data source (e.g., MasterOrderProgramsList).
                        if let program = MasterOrderProgramsList.first(where: { $0.program_Id == programId }) {
                            // Populate the text fields with program details.
                            programIdField.text = "\(program.program_Id)"
                            programNameField.text = program.name
                            messageLabel.text = "Program found. You can update its details."
                        } else {
                            messageLabel.text = "Program with ID \(programId) not found."
                        }
                    } else {
                        messageLabel.text = "Invalid input. Please enter a valid integer for Program ID."
                    }
                }
            }
        }
    }

    @objc func updateProgram(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2) {
            if let updateProgramView = manageCollegesView.viewWithTag(60) {
                if let programIdField = updateProgramView.subviews.first(where: { $0 is UITextField && $0.tag == 8 }) as? UITextField,
                   let programNameField = updateProgramView.subviews.first(where: { $0 is UITextField && $0.tag == 9 }) as? UITextField,
                   let collegeIdField = updateProgramView.subviews.first(where: { $0 is UITextField && $0.tag == 10 }) as? UITextField,
                   let messageLabel = updateProgramView.viewWithTag(61) as? UILabel {
                    
                    if let programId = Int(programIdField.text ?? "") {
                        if let program = MasterOrderProgramsList.first(where: { $0.program_Id == programId }) {
                            if let collegeId = Int(collegeIdField.text ?? "") {
                                if colleges.contains(where: { $0.college_Id == collegeId }) {
                                    if !programNameField.text!.isEmpty {
                                        // Update the program details.
                                        program.program_Id = programId
                                        program.name = programNameField.text!
                                        program.college_Id = collegeId
                                        messageLabel.text = "Program updated successfully!"
                                    } else {
                                        messageLabel.text = "Fill all fields."
                                    }
                                } else {
                                    messageLabel.text = "Invalid college ID. Please choose a valid college ID."
                                }
                            } else {
                                messageLabel.text = "Invalid input. Please enter a valid integer for College ID."
                            }
                        } else {
                            messageLabel.text = "Invalid input. Program with the given ID does not exist."
                        }
                    } else {
                        messageLabel.text = "Invalid input. Please enter a valid integer for Program ID."
                    }
                }
            }
        }
    }




    
    @objc func deleteProgramView(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2) {
            let deleteProgramView = UIView(frame: manageCollegesView.bounds)
            deleteProgramView.backgroundColor = UIColor.lightGray
            deleteProgramView.tag = 70
            manageCollegesView.addSubview(deleteProgramView)
            
            let programIdField = UITextField(frame: CGRect(x: 75, y: 350, width: 250, height: 50))
            programIdField.textAlignment = NSTextAlignment.center
            programIdField.textColor = UIColor.black
            programIdField.backgroundColor = UIColor.white
            programIdField.borderStyle = UITextField.BorderStyle.roundedRect
            programIdField.clearButtonMode = .whileEditing
            programIdField.placeholder = "Enter Program ID to Delete"
            programIdField.keyboardType = .numberPad
            programIdField.returnKeyType = .done
            programIdField.tag = 71
            deleteProgramView.addSubview(programIdField)
            
            let deleteProgramBtn = UIButton(frame: CGRect(x: 75, y: 410, width: 250, height: 50))
            deleteProgramBtn.setTitle("Delete Program", for: .normal)
            deleteProgramBtn.backgroundColor = UIColor.systemBlue
            deleteProgramBtn.layer.cornerRadius = 10
            deleteProgramBtn.addTarget(self, action: #selector(deleteProgram), for: .touchUpInside)
            deleteProgramView.addSubview(deleteProgramBtn)
            
            // Add a message label to display status messages
            let messageLabel = UILabel(frame: CGRect(x: 75, y: 470, width: 250, height: 40))
            messageLabel.textAlignment = .center
            messageLabel.tag = 72
            deleteProgramView.addSubview(messageLabel)
            
            let backToManageCollegesBtn = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            backToManageCollegesBtn.setTitle("Back to Manage Programs", for: .normal)
            backToManageCollegesBtn.backgroundColor = UIColor.systemBlue
            backToManageCollegesBtn.layer.cornerRadius = 10
            backToManageCollegesBtn.addTarget(self, action: #selector(switchToColleges), for: .touchUpInside)
            deleteProgramView.addSubview(backToManageCollegesBtn)
        }
    }

    @objc func deleteProgram(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2) {
            if let deleteProgramView = manageCollegesView.viewWithTag(70) {
                if let programIdField = deleteProgramView.subviews.first(where: { $0 is UITextField && $0.tag == 71 }) as? UITextField,
                   let messageLabel = deleteProgramView.viewWithTag(72) as? UILabel {
                    
                    if let programId = Int(programIdField.text ?? "") {
                        if let college = colleges.first(where: { $0.programs.contains(where: { $0.program_Id == programId }) }) {
                            if let index = college.programs.firstIndex(where: { $0.program_Id == programId }) {
                                let program = college.programs[index]
                                if let indexInMasterList = MasterOrderProgramsList.firstIndex(where: { $0.program_Id == programId }) {
                                    MasterOrderProgramsList.remove(at: indexInMasterList)
                                }
                                college.programs.remove(at: index)
                                messageLabel.text = "Program deleted successfully!"
                            } else {
                                messageLabel.text = "Program with ID \(programId) not found in this college."
                            }
                        } else {
                            messageLabel.text = "Program with ID \(programId) not found in any college."
                        }
                    } else {
                        messageLabel.text = "Invalid input. Please enter a valid integer for Program ID."
                    }
                }
            }
        }
    }

    
    @objc func displayProgramsView(sender: UIButton) {
        if let manageCollegesView = window?.viewWithTag(2) {
            let displayProgramsView = UIView(frame: manageCollegesView.bounds)
            displayProgramsView.backgroundColor = UIColor.lightGray
            displayProgramsView.tag = 80
            manageCollegesView.addSubview(displayProgramsView)
            
            // Add a label to display program information
            let programInfoLabel = UILabel(frame: CGRect(x: 10, y: 10, width: displayProgramsView.frame.width - 20, height: displayProgramsView.frame.height - 70))
            programInfoLabel.numberOfLines = 0 // Allow multiple lines
            programInfoLabel.textAlignment = .left
            programInfoLabel.textColor = UIColor.black
            programInfoLabel.text = "Programs Information:\n"
            
            // Append program information to the label
            for (index, program) in MasterOrderProgramsList.enumerated() {
                programInfoLabel.text?.append("\n\(index + 1). Program ID: \(program.program_Id)\nName: \(program.name)\nCollege ID: \(program.college_Id)\n")
            }
            
            displayProgramsView.addSubview(programInfoLabel)
            
            let backToManageCollegesBtn = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            backToManageCollegesBtn.setTitle("Back to Manage Programs", for: .normal)
            backToManageCollegesBtn.backgroundColor = UIColor.systemBlue
            backToManageCollegesBtn.layer.cornerRadius = 10
            backToManageCollegesBtn.addTarget(self, action: #selector(switchToColleges), for: .touchUpInside)
            displayProgramsView.addSubview(backToManageCollegesBtn)
        }
    }
    
    @objc func addCategory(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3) {
            let addCatView = UIView(frame: manageCCView.bounds)
            addCatView.backgroundColor = UIColor.lightGray
            addCatView.tag = 70
            manageCCView.addSubview(addCatView)
            
            // Create text fields for category ID and name
            let textAddCatFields = createAddCatTextFields()
            let catIdField = textAddCatFields.0
            let catNameField = textAddCatFields.1
            addCatView.addSubview(catIdField)
            addCatView.addSubview(catNameField)
            
            // Add Category button
            let addCatBtn = UIButton(frame: CGRect(x: 75, y: 530, width: 250, height: 50))
            addCatBtn.setTitle("Add Category", for: .normal)
            addCatBtn.backgroundColor = UIColor.systemBlue
            addCatBtn.layer.cornerRadius = 10
            addCatBtn.addTarget(self, action: #selector(addCat(sender:)), for: .touchUpInside)
            addCatView.addSubview(addCatBtn)
            
            // Add a message label to display status messages
            let messageLabel = UILabel(frame: CGRect(x: 75, y: 300, width: 250, height: 40))
            messageLabel.textAlignment = .center
            addCatView.addSubview(messageLabel)
            
            // Set the tag for the message label to easily update its text
            messageLabel.tag = 71
            
            // Back to Manage Course Categories
            let backToManageCC = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            backToManageCC.setTitle("Back to Manage Categories", for: .normal)
            backToManageCC.backgroundColor = UIColor.systemBlue
            backToManageCC.layer.cornerRadius = 10
            backToManageCC.addTarget(self, action: #selector(switchToMainMenu(sender:)), for: .touchUpInside)
            addCatView.addSubview(backToManageCC)
        }
    }

    @objc func addCat(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3) {
            if let addCatView = manageCCView.viewWithTag(70) {
                if let catIdField = addCatView.viewWithTag(11) as? UITextField,
                   let catNameField = addCatView.viewWithTag(12) as? UITextField,
                   let messageLabel = addCatView.viewWithTag(71) as? UILabel {
                    
                    // Check if all fields are filled
                    if !catIdField.text!.isEmpty && !catNameField.text!.isEmpty {
                        if let catId = Int(catIdField.text ?? "") {
                            if !categories.contains(where: { $0.category_Id == catId }) {
                                let name = catNameField.text!
                                let newCategory = Course_Category(category_Id: catId, name: name)
                                categories.append(newCategory)
                                messageLabel.text = "\(name) added successfully!"
                            } else {
                                messageLabel.text = "Category with ID \(catIdField.text ?? "") already exists. Please choose a different ID."
                            }
                        } else {
                            messageLabel.text = "Invalid input. Please enter a valid integer for Category ID."
                        }
                    } else {
                        messageLabel.text = "Fill all fields."
                    }
                }
            }
        }
    }
    
    @objc func updateCategory(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3) {
            let updCatView = UIView(frame: manageCCView.bounds)
            updCatView.backgroundColor = UIColor.lightGray
            updCatView.tag = 72
            manageCCView.addSubview(updCatView)
            
            let textFields = createUpdCatTextFields()
            let catIdField = textFields.0
            let catNameField = textFields.1
            
            updCatView.addSubview(catIdField)
            updCatView.addSubview(catNameField)
            
            let fetchCategoryBtn = UIButton(frame: CGRect(x: 75, y: 530, width: 250, height: 50))
            fetchCategoryBtn.setTitle("Fetch Category", for: .normal)
            fetchCategoryBtn.backgroundColor = UIColor.systemBlue
            fetchCategoryBtn.layer.cornerRadius = 10
            fetchCategoryBtn.addTarget(self, action: #selector(fetchCategory), for: .touchUpInside)
            updCatView.addSubview(fetchCategoryBtn)
            
            // Add a message label to display status messages
            let messageLabel = UILabel(frame: CGRect(x: 75, y: 590, width: 250, height: 40))
            messageLabel.textAlignment = .center
            messageLabel.tag = 73
            updCatView.addSubview(messageLabel)
            
            let updateCategoryBtn = UIButton(frame: CGRect(x: 75, y: 640, width: 250, height: 50))
            updateCategoryBtn.setTitle("Update Category", for: .normal)
            updateCategoryBtn.backgroundColor = UIColor.systemBlue
            updateCategoryBtn.layer.cornerRadius = 10
            updateCategoryBtn.addTarget(self, action: #selector(updateCategoryDetails), for: .touchUpInside)
            updCatView.addSubview(updateCategoryBtn)
            
            let backToManageCC = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            backToManageCC.setTitle("Back to Manage Categories", for: .normal)
            backToManageCC.backgroundColor = UIColor.systemBlue
            backToManageCC.layer.cornerRadius = 10
            backToManageCC.addTarget(self, action: #selector(switchToMainMenu(sender:)), for: .touchUpInside)
            updCatView.addSubview(backToManageCC)
        }
    }

    @objc func fetchCategory(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3) {
            if let updCatView = manageCCView.viewWithTag(72) {
                if let catIdField = updCatView.subviews.first(where: { $0 is UITextField && $0.tag == 13 }) as? UITextField,
                    let catNameField = updCatView.subviews.first(where: { $0 is UITextField && $0.tag == 14 }) as? UITextField,
                    let messageLabel = updCatView.viewWithTag(73) as? UILabel {
                    
                    if let catId = Int(catIdField.text ?? "") {
                        if let category = categories.first(where: { $0.category_Id == catId }) {
                            catNameField.text = category.name
                            messageLabel.text = "Category found. You can update its details."
                        } else {
                            messageLabel.text = "Category with ID \(catId) not found."
                        }
                    } else {
                        messageLabel.text = "Invalid input. Please enter a valid integer for Category ID."
                    }
                }
            }
        }
    }

    @objc func updateCategoryDetails(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3) {
            if let updCatView = manageCCView.viewWithTag(72) {
                if let catIdField = updCatView.subviews.first(where: { $0 is UITextField && $0.tag == 13 }) as? UITextField,
                    let catNameField = updCatView.subviews.first(where: { $0 is UITextField && $0.tag == 14 }) as? UITextField,
                    let messageLabel = updCatView.viewWithTag(73) as? UILabel {
                    
                    if let catId = Int(catIdField.text ?? ""), let index = categories.firstIndex(where: { $0.category_Id == catId }) {
                        if !catNameField.text!.isEmpty {
                            let name = catNameField.text!
                            categories[index].name = name
                            messageLabel.text = "Category updated successfully!"
                        } else {
                            messageLabel.text = "Fill all fields."
                        }
                    } else {
                        messageLabel.text = "Invalid input. Category with the given ID does not exist."
                    }
                }
            }
        }
    }

    @objc func deleteCategory(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3) {
            let delCatView = UIView(frame: manageCCView.bounds)
            delCatView.backgroundColor = UIColor.lightGray
            delCatView.tag = 74
            manageCCView.addSubview(delCatView)
            
            let categoryIdField = UITextField(frame: CGRect(x: 75.0, y: 350.0, width: 250.0, height: 50.0))
            categoryIdField.textAlignment = NSTextAlignment.center
            categoryIdField.textColor = UIColor.black
            categoryIdField.backgroundColor = UIColor.white
            categoryIdField.borderStyle = UITextField.BorderStyle.roundedRect
            categoryIdField.clearButtonMode = .whileEditing
            categoryIdField.placeholder = "Enter Category ID to delete"
            categoryIdField.keyboardType = .default
            categoryIdField.returnKeyType = .done
            
            delCatView.addSubview(categoryIdField)
            
            let delCatBtn = UIButton(frame: CGRect(x: 75, y: 410, width: 250, height: 50))
            delCatBtn.setTitle("Delete Category", for: .normal)
            delCatBtn.backgroundColor = UIColor.systemBlue
            delCatBtn.layer.cornerRadius = 10
            delCatBtn.addTarget(self, action: #selector(delCategory), for: .touchUpInside)
            delCatView.addSubview(delCatBtn)
            
            let messageLabel = UILabel(frame: CGRect(x: 75, y: 280, width: 250, height: 40))
            messageLabel.textAlignment = .center
            messageLabel.tag = 75
            delCatView.addSubview(messageLabel)
            
            let backBtnMngCC = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            backBtnMngCC.setTitle("Back to Manage Categories", for: .normal)
            backBtnMngCC.backgroundColor = UIColor.systemBlue
            backBtnMngCC.layer.cornerRadius = 10
            backBtnMngCC.addTarget(self, action: #selector(switchToMainMenu(sender:)), for: .touchUpInside)
            delCatView.addSubview(backBtnMngCC)
        }
    }

    @objc func delCategory(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3) {
            if let delCatView = manageCCView.viewWithTag(74) {
                if let categoryIdField = delCatView.subviews.first(where: { $0 is UITextField && $0.tag == 0 }) as? UITextField,
                   let messageLabel = delCatView.viewWithTag(75) as? UILabel {
                    
                    if let categoryId = Int(categoryIdField.text ?? "") {
                        if let index = categories.firstIndex(where: { $0.category_Id == categoryId }) {
                            let category = categories[index]
                            if category.courses.isEmpty {
                                categories.remove(at: index)
                                messageLabel.text = "Category deleted successfully!"
                            } else {
                                messageLabel.text = "Cannot delete category with courses.Please delete the courses first."
                            }
                        } else {
                            messageLabel.text = "Category with ID \(categoryId) not found."
                        }
                    } else {
                        messageLabel.text = "Invalid input. Please enter a valid integer for Category ID."
                    }
                }
            }
        }
    }
    
    @objc func displayCategories(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3) {
            let dispCatView = UIView(frame: manageCCView.bounds)
            dispCatView.backgroundColor = UIColor.lightGray
            dispCatView.tag = 76
            manageCCView.addSubview(dispCatView)
            
            // Add a label to display category information
            let categoryInfoLabel = UILabel(frame: CGRect(x: 10, y: 10, width: dispCatView.frame.width - 20, height: dispCatView.frame.height - 70))
            categoryInfoLabel.numberOfLines = 0 // Allow multiple lines
            categoryInfoLabel.textAlignment = .left
            categoryInfoLabel.textColor = UIColor.black
            categoryInfoLabel.text = "Course Categories Information:\n"
            
            // Append category information to the label
            for (index, category) in categories.enumerated() {
                categoryInfoLabel.text?.append("\n\(index + 1). Category ID: \(category.category_Id)\nName: \(category.name)\n")
            }
            
            dispCatView.addSubview(categoryInfoLabel)
            
            let backToManageCC = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            backToManageCC.setTitle("Back to Manage Categories", for: .normal)
            backToManageCC.backgroundColor = UIColor.systemBlue
            backToManageCC.layer.cornerRadius = 10
            backToManageCC.addTarget(self, action: #selector(switchToMainMenu(sender:)), for: .touchUpInside)
            dispCatView.addSubview(backToManageCC)
        }
    }

    @objc func selectCategory(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3) {
            if let categoryIdField = manageCCView.viewWithTag(35) as? UITextField,
                let categoryIdText = categoryIdField.text,
                let categoryId = Int(categoryIdText),
                let category = categories.first(where: { $0.category_Id == categoryId }) {
                print("Selected Category: \(category.name)")
                
                // Pass the selected category to the view
                let selectCategoryView = UIView(frame: manageCCView.bounds)
                selectCategoryView.backgroundColor = UIColor.lightGray
                selectCategoryView.tag = 77
                manageCCView.addSubview(selectCategoryView)
                
                // Add buttons for managing courses within the selected category
                let addCourseBtn = UIButton(frame: CGRect(x: 75, y: 280, width: 250, height: 50))
                addCourseBtn.setTitle("Add Course", for: .normal)
                addCourseBtn.backgroundColor = UIColor.systemBlue
                addCourseBtn.layer.cornerRadius = 10
                addCourseBtn.addTarget(self, action: #selector(addCourseView(sender:)), for: .touchUpInside)
                selectCategoryView.addSubview(addCourseBtn)
                
                let updateCourseBtn = UIButton(frame: CGRect(x: 75, y: 340, width: 250, height: 50))
                updateCourseBtn.setTitle("Update Course", for: .normal)
                updateCourseBtn.backgroundColor = UIColor.systemBlue
                updateCourseBtn.layer.cornerRadius = 10
                updateCourseBtn.addTarget(self, action: #selector(updateCourseView(sender:)), for: .touchUpInside)
                selectCategoryView.addSubview(updateCourseBtn)
                
                let deleteCourseBtn = UIButton(frame: CGRect(x: 75, y: 400, width: 250, height: 50))
                deleteCourseBtn.setTitle("Delete Course", for: .normal)
                deleteCourseBtn.backgroundColor = UIColor.systemBlue
                deleteCourseBtn.layer.cornerRadius = 10
                deleteCourseBtn.addTarget(self, action: #selector(deleteCourseView(sender:)), for: .touchUpInside)
                selectCategoryView.addSubview(deleteCourseBtn)
                
                let displayCoursesBtn = UIButton(frame: CGRect(x: 75, y: 460, width: 250, height: 50))
                                displayCoursesBtn.setTitle("Display Courses", for: .normal)
                                displayCoursesBtn.backgroundColor = UIColor.systemBlue
                                displayCoursesBtn.layer.cornerRadius = 10
                                displayCoursesBtn.addTarget(self, action: #selector(displayCoursesView(sender:)), for: .touchUpInside)
                                selectCategoryView.addSubview(displayCoursesBtn)
                 
                let backToCategoriesBtn = UIButton(frame: CGRect(x: 75, y: 520, width: 250, height: 50))
                backToCategoriesBtn.setTitle("Back to Categories", for: .normal)
                backToCategoriesBtn.backgroundColor = UIColor.systemBlue
                backToCategoriesBtn.layer.cornerRadius = 10
                backToCategoriesBtn.addTarget(self, action: #selector(switchToColleges(sender:)), for: .touchUpInside)
                selectCategoryView.addSubview(backToCategoriesBtn)
            } else {
                let notFoundLabel = UILabel(frame: CGRect(x: 75, y: 100, width: 250, height: 40))
                notFoundLabel.textAlignment = .center
                notFoundLabel.text = "Category ID does not exist."
                manageCCView.addSubview(notFoundLabel)
            }
        }
    }


    @objc func addCourseView(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3), let selectCategoryView = manageCCView.viewWithTag(77) {
            let addCourseView = UIView(frame: selectCategoryView.bounds)
            addCourseView.backgroundColor = UIColor.lightGray
            addCourseView.tag = 81
            selectCategoryView.addSubview(addCourseView)

            let textAddCourseFields = createAddCourseTextFields()
            let courseIdField = textAddCourseFields.0
            let courseNameField = textAddCourseFields.1
            let collegeIdField = textAddCourseFields.2
            let programIdField = textAddCourseFields.3
            let categoryIdField = textAddCourseFields.4

            courseIdField.tag = 15 // Set tag for courseIdField
            courseNameField.tag = 16 // Set tag for courseNameField
            collegeIdField.tag = 17 // Set tag for collegeIdField
            programIdField.tag = 18 // Set tag for programIdField
            categoryIdField.tag = 19 // Set tag for categoryIdField

            addCourseView.addSubview(courseIdField)
            addCourseView.addSubview(courseNameField)
            addCourseView.addSubview(collegeIdField)
            addCourseView.addSubview(programIdField)
            addCourseView.addSubview(categoryIdField)

            let addCourseBtn = UIButton(frame: CGRect(x: 75, y: 530, width: 250, height: 50))
            addCourseBtn.setTitle("Add Course", for: .normal)
            addCourseBtn.backgroundColor = UIColor.systemBlue
            addCourseBtn.layer.cornerRadius = 10
            addCourseBtn.addTarget(self, action: #selector(addCourseToCategory), for: .touchUpInside)
            addCourseView.addSubview(addCourseBtn)

            // Add a message label to display status messages
            let messageLabel = UILabel(frame: CGRect(x: 75, y: 200, width: 250, height: 40))
            messageLabel.textAlignment = .center
            addCourseView.addSubview(messageLabel)

            // Set the tag for the message label to easily update its text
            messageLabel.tag = 82

            let backToCategoriesBtn = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            backToCategoriesBtn.setTitle("Back to Manage Courses", for: .normal)
            backToCategoriesBtn.backgroundColor = UIColor.systemBlue
            backToCategoriesBtn.layer.cornerRadius = 10
            backToCategoriesBtn.addTarget(self, action: #selector(switchToColleges(sender:)), for: .touchUpInside)
            addCourseView.addSubview(backToCategoriesBtn)
        }
    }

    @objc func addCourseToCategory(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3), let selectCategoryView = manageCCView.viewWithTag(77) {
            if let courseIdField = selectCategoryView.viewWithTag(15) as? UITextField,
               let courseNameField = selectCategoryView.viewWithTag(16) as? UITextField,
               let collegeIdField = selectCategoryView.viewWithTag(17) as? UITextField,
               let programIdField = selectCategoryView.viewWithTag(18) as? UITextField,
               let categoryIdField = selectCategoryView.viewWithTag(19) as? UITextField,
               let messageLabel = selectCategoryView.viewWithTag(82) as? UILabel,
               let courseIdText = courseIdField.text, !courseIdText.isEmpty,
               let courseId = Int(courseIdText),
               let courseName = courseNameField.text, !courseName.isEmpty,
               let collegeIdText = collegeIdField.text, !collegeIdText.isEmpty,
               let collegeId = Int(collegeIdText),
               let programIdText = programIdField.text, !programIdText.isEmpty,
               let programId = Int(programIdText),
               let categoryIdText = categoryIdField.text, !categoryIdText.isEmpty,
               let categoryId = Int(categoryIdText) {

                // Check if the selected category ID exists
                if let category = categories.first(where: { $0.category_Id == categoryId }) {
                    // Check if the course ID is unique in the selected category
                    if !category.courses.contains(where: { $0.course_Id == courseId }) {
                        // Check if the provided college ID exists
                        if let college = colleges.first(where: { $0.college_Id == collegeId }) {
                            // Check if the provided program ID exists in the selected college
                            if college.programs.contains(where: { $0.program_Id == programId }) {
                                // Set the course_Id of the newCourse to the selected category's ID
                                let newCourse = Course(course_Id: courseId, name: courseName, college_Id: collegeId, program_Id: programId, category_Id: categoryId)
                                category.courses.append(newCourse)
                                MasterOrderCourseList.append(newCourse)
                                messageLabel.text = "\(courseName) added to \(category.name) successfully!"
                            } else {
                                messageLabel.text = "Program with ID \(programId) does not exist in the selected college."
                            }
                        } else {
                            messageLabel.text = "College with ID \(collegeId) does not exist."
                        }
                    } else {
                        messageLabel.text = "Course with ID \(courseId) already exists in \(category.name). Please choose a different ID."
                    }
                } else {
                    messageLabel.text = "Selected category does not exist."
                }
            }
        }
    }
    
    @objc func updateCourseView(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3), let selectCategoryView = manageCCView.viewWithTag(77) {
            let updateCourseView = UIView(frame: selectCategoryView.bounds)
            updateCourseView.backgroundColor = UIColor.lightGray
            updateCourseView.tag = 803
            selectCategoryView.addSubview(updateCourseView)

            let textFields = createUpdCourseTextFields()
            let courseIdField = textFields.0
            let courseNameField = textFields.1
            let collegeIdField = textFields.2
            let programIdField = textFields.3
            let categoryIdField = textFields.4

            courseIdField.tag = 201 // Set tag for courseIdField
            courseNameField.tag = 202 // Set tag for courseNameField
            collegeIdField.tag = 203// Set tag for collegeIdField
            programIdField.tag = 204 // Set tag for programIdField
            categoryIdField.tag = 205 // Set tag for categoryIdField

            updateCourseView.addSubview(courseIdField)
            updateCourseView.addSubview(courseNameField)
            updateCourseView.addSubview(collegeIdField)
            updateCourseView.addSubview(programIdField)
            updateCourseView.addSubview(categoryIdField)

            let fetchCourseBtn = UIButton(frame: CGRect(x: 75, y: 530, width: 250, height: 50))
            fetchCourseBtn.setTitle("Fetch Course", for: .normal)
            fetchCourseBtn.backgroundColor = UIColor.systemBlue
            fetchCourseBtn.layer.cornerRadius = 10
            fetchCourseBtn.addTarget(self, action: #selector(fetchCourse), for: .touchUpInside)
            updateCourseView.addSubview(fetchCourseBtn)

            // Add a message label to display status messages
            let messageLabel = UILabel(frame: CGRect(x: 75, y: 590, width: 250, height: 40))
            messageLabel.textAlignment = .center
            messageLabel.tag = 804
            updateCourseView.addSubview(messageLabel)

            let updateCourseBtn = UIButton(frame: CGRect(x: 75, y: 640, width: 250, height: 50))
            updateCourseBtn.setTitle("Update Course", for: .normal)
            updateCourseBtn.backgroundColor = UIColor.systemBlue
            updateCourseBtn.layer.cornerRadius = 10
            updateCourseBtn.addTarget(self, action: #selector(updateCourse), for: .touchUpInside)
            updateCourseView.addSubview(updateCourseBtn)

            let backToCategoriesBtn = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            backToCategoriesBtn.setTitle("Back to Manage Courses", for: .normal)
            backToCategoriesBtn.backgroundColor = UIColor.systemBlue
            backToCategoriesBtn.layer.cornerRadius = 10
            backToCategoriesBtn.addTarget(self, action: #selector(switchToColleges(sender:)), for: .touchUpInside)
            updateCourseView.addSubview(backToCategoriesBtn)
        }
    }

    @objc func fetchCourse(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3), let selectCategoryView = manageCCView.viewWithTag(77) {
            if let updateCourseView = selectCategoryView.viewWithTag(803) {
                if let courseIdField = updateCourseView.subviews.first(where: { $0 is UITextField && $0.tag == 201 }) as? UITextField,
                    let courseNameField = updateCourseView.subviews.first(where: { $0 is UITextField && $0.tag == 202 }) as? UITextField,
                    let collegeIdField = updateCourseView.subviews.first(where: { $0 is UITextField && $0.tag == 203 }) as? UITextField,
                    let programIdField = updateCourseView.subviews.first(where: { $0 is UITextField && $0.tag == 204 }) as? UITextField,
                    let categoryIdField = updateCourseView.subviews.first(where: { $0 is UITextField && $0.tag == 205 }) as? UITextField,
                    let messageLabel = updateCourseView.viewWithTag(804) as? UILabel {

                    if let courseId = Int(courseIdField.text ?? ""), let categoryId = Int(categoryIdField.text ?? "") {
                        if let category = categories.first(where: { $0.category_Id == categoryId }) {
                            if let course = category.courses.first(where: { $0.course_Id == courseId }) {
                                // Fill in the fetched course details
                                courseNameField.text = course.name
                                collegeIdField.text = String(course.college_Id)
                                programIdField.text = String(course.program_Id)
                                messageLabel.text = "Course found. You can update its details."
                            } else {
                                messageLabel.text = "Course with ID \(courseId) not found in the selected category."
                            }
                        } else {
                            messageLabel.text = "Invalid Category ID. Please choose a valid Category ID."
                        }
                    } else {
                        messageLabel.text = "Invalid input. Please enter valid Course and Category IDs."
                    }
                }
            }
        }
    }

    @objc func updateCourse(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3), let selectCategoryView = manageCCView.viewWithTag(77) {
            if let updateCourseView = selectCategoryView.viewWithTag(803) {
                if let courseIdField = updateCourseView.subviews.first(where: { $0 is UITextField && $0.tag == 201 }) as? UITextField,
                    let courseNameField = updateCourseView.subviews.first(where: { $0 is UITextField && $0.tag == 202 }) as? UITextField,
                    let collegeIdField = updateCourseView.subviews.first(where: { $0 is UITextField && $0.tag == 203 }) as? UITextField,
                    let programIdField = updateCourseView.subviews.first(where: { $0 is UITextField && $0.tag == 204 }) as? UITextField,
                    let categoryIdField = updateCourseView.subviews.first(where: { $0 is UITextField && $0.tag == 205 }) as? UITextField,
                    let messageLabel = updateCourseView.viewWithTag(84) as? UILabel {

                    if let courseId = Int(courseIdField.text ?? ""), let categoryId = Int(categoryIdField.text ?? "") {
                        if let category = categories.first(where: { $0.category_Id == categoryId }) {
                            if let course = category.courses.first(where: { $0.course_Id == courseId }) {
                                if !courseNameField.text!.isEmpty, let newCollegeId = Int(collegeIdField.text ?? ""), let newProgramId = Int(programIdField.text ?? "") {
                                    if !categories.contains(where: { $0.category_Id == categoryId }) {
                                        messageLabel.text = "Invalid Category ID. Please choose a valid Category ID."
                                    } else if !colleges.contains(where: { $0.college_Id == newCollegeId }) {
                                        messageLabel.text = "Invalid College ID. Please choose a valid College ID."
                                    } else if let college = colleges.first(where: { $0.college_Id == newCollegeId }), !college.programs.contains(where: { $0.program_Id == newProgramId }) {
                                        messageLabel.text = "Invalid Program ID for the selected College. Please choose a valid Program ID."
                                    } else {
                                        // Update course details
                                        course.name = courseNameField.text!
                                        course.college_Id = newCollegeId
                                        course.program_Id = newProgramId
                                        messageLabel.text = "Course updated successfully!"

                                        if let indexInMasterList = MasterOrderCourseList.firstIndex(where: { $0.course_Id == courseId }) {
                                            // Find the index of the old course in the MasterOrderCourseList.
                                            MasterOrderCourseList[indexInMasterList] = course
                                            // Replace the old course with the updated course in the MasterOrderCourseList.
                                        }
                                    }
                                } else {
                                    messageLabel.text = "Fill in all fields."
                                }
                            } else {
                                messageLabel.text = "Course with ID \(courseId) not found in the selected category."
                            }
                        } else {
                            messageLabel.text = "Invalid Category ID. Please choose a valid Category ID."
                        }
                    } else {
                        messageLabel.text = "Invalid input. Please enter valid Course and Category IDs."
                    }
                }
            }
        }
    }


    

    @objc func deleteCourseView(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3), let selectCategoryView = manageCCView.viewWithTag(77) {
            let deleteCourseView = UIView(frame: selectCategoryView.bounds)
            deleteCourseView.backgroundColor = UIColor.lightGray
            deleteCourseView.tag = 85
            selectCategoryView.addSubview(deleteCourseView)

            let courseIdField = UITextField(frame: CGRect(x: 75, y: 350, width: 250, height: 50))
            courseIdField.textAlignment = NSTextAlignment.center
            courseIdField.textColor = UIColor.black
            courseIdField.backgroundColor = UIColor.white
            courseIdField.borderStyle = UITextField.BorderStyle.roundedRect
            courseIdField.clearButtonMode = .whileEditing
            courseIdField.placeholder = "Enter Course ID to Delete"
            courseIdField.keyboardType = .numberPad
            courseIdField.returnKeyType = .done
            courseIdField.tag = 86
            deleteCourseView.addSubview(courseIdField)

            let deleteCourseBtn = UIButton(frame: CGRect(x: 75, y: 410, width: 250, height: 50))
            deleteCourseBtn.setTitle("Delete Course", for: .normal)
            deleteCourseBtn.backgroundColor = UIColor.systemBlue
            deleteCourseBtn.layer.cornerRadius = 10
            deleteCourseBtn.addTarget(self, action: #selector(deleteCourse), for: .touchUpInside)
            deleteCourseView.addSubview(deleteCourseBtn)

            // Add a message label to display status messages
            let messageLabel = UILabel(frame: CGRect(x: 75, y: 470, width: 250, height: 40))
            messageLabel.textAlignment = .center
            messageLabel.tag = 87
            deleteCourseView.addSubview(messageLabel)

            let backToManageCCBtn = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            backToManageCCBtn.setTitle("Back to Manage Courses", for: .normal)
            backToManageCCBtn.backgroundColor = UIColor.systemBlue
            backToManageCCBtn.layer.cornerRadius = 10
            backToManageCCBtn.addTarget(self, action: #selector(switchToColleges(sender:)), for: .touchUpInside)
            deleteCourseView.addSubview(backToManageCCBtn)
        }
    }

    @objc func deleteCourse(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3), let selectCategoryView = manageCCView.viewWithTag(77) {
            if let deleteCourseView = selectCategoryView.viewWithTag(85) {
                if let courseIdField = deleteCourseView.subviews.first(where: { $0 is UITextField && $0.tag == 86 }) as? UITextField,
                    let messageLabel = deleteCourseView.viewWithTag(87) as? UILabel {
                    
                    if let courseId = Int(courseIdField.text ?? "") {
                        for category in categories {
                            if let index = category.courses.firstIndex(where: { $0.course_Id == courseId }) {
                                let course = category.courses[index]
                                let oldCourse = course
                                category.courses.remove(at: index)
                                messageLabel.text = "Course deleted successfully!"

                                if let indexInMasterList = MasterOrderCourseList.firstIndex(where: { $0.course_Id == oldCourse.course_Id }) {
                                    MasterOrderCourseList.remove(at: indexInMasterList)
                                }
                                return // Exit the loop once a course is deleted
                            }
                        }
                        messageLabel.text = "Course with ID \(courseId) not found in any category."
                    } else {
                        messageLabel.text = "Invalid input. Please enter a valid Course ID."
                    }
                }
            }
        }
    }


    @objc func displayCoursesView(sender: UIButton) {
        if let manageCCView = window?.viewWithTag(3), let selectCategoryView = manageCCView.viewWithTag(77) {
            let displayCoursesView = UIView(frame: selectCategoryView.bounds)
            displayCoursesView.backgroundColor = UIColor.lightGray
            displayCoursesView.tag = 88
            selectCategoryView.addSubview(displayCoursesView)

            // Add a label to display course information
            let courseInfoLabel = UILabel(frame: CGRect(x: 10, y: 10, width: displayCoursesView.frame.width - 20, height: displayCoursesView.frame.height - 70))
            courseInfoLabel.numberOfLines = 0 // Allow multiple lines
            courseInfoLabel.textAlignment = .left
            courseInfoLabel.textColor = UIColor.black
            courseInfoLabel.text = "Courses Information:\n"

            // Append course information to the label
            for (index, course) in MasterOrderCourseList.enumerated() {
                courseInfoLabel.text?.append("\n\(index + 1). Course ID: \(course.course_Id)\nName: \(course.name)\nCollege ID: \(course.college_Id)\nProgram ID: \(course.program_Id)\nCategory ID: \(course.category_Id)\n")
            }

            displayCoursesView.addSubview(courseInfoLabel)

            let backToCategoriesBtn = UIButton(frame: CGRect(x: 75, y: 700, width: 250, height: 50))
            backToCategoriesBtn.setTitle("Back to Manage Courses", for: .normal)
            backToCategoriesBtn.backgroundColor = UIColor.systemBlue
            backToCategoriesBtn.layer.cornerRadius = 10
            backToCategoriesBtn.addTarget(self, action: #selector(switchToColleges(sender:)), for: .touchUpInside)
            displayCoursesView.addSubview(backToCategoriesBtn)
        }
    }



    
    @objc func searchClgs(sender: UIButton) {
        if let searchItView = window?.viewWithTag(4) {
            if let searchClgField = searchItView.subviews.first(where: { $0 is UITextField && $0.tag == 1000 }) as? UITextField,
               let InfoLabel = searchItView.subviews.first(where: { $0 is UILabel }) as? UILabel {
                
                if let searchName = searchClgField.text, !searchName.isEmpty {
                    var foundColleges: [College] = []
                    
                    for college in colleges {
                        if college.name.lowercased().contains(searchName.lowercased()) {
                            foundColleges.append(college)
                        }
                    }
                    
                    if foundColleges.isEmpty {
                        InfoLabel.text = "No colleges found with the name '\(searchName)'."
                    } else {
                        var infoText = "Colleges found with the name '\(searchName)':\n"
                        for (index, college) in foundColleges.enumerated() {
                            infoText.append("\(index + 1). College ID: \(college.college_Id)\n Name: \(college.name)\n Address: \(college.address)\n")
                        }
                        InfoLabel.text = infoText
                    }
                } else {
                    InfoLabel.text = "Invalid input for college Name. Please try again."
                }
            }
        }
    }

    @objc func searchPros(sender: UIButton) {
        if let searchItView = window?.viewWithTag(4) {
            if let searchProField = searchItView.subviews.first(where: { $0 is UITextField && $0.tag == 1001 }) as? UITextField,
               let InfoLabel = searchItView.subviews.first(where: { $0 is UILabel }) as? UILabel {
                
                if let searchName = searchProField.text, !searchName.isEmpty {
                    var foundPrograms: [Program] = []
                    
                    for program in MasterOrderProgramsList {
                        if program.name.lowercased().contains(searchName.lowercased()) {
                            foundPrograms.append(program)
                        }
                    }
                    
                    InfoLabel.text = "Programs found with the name '\(searchName)':\n"
                    
                    if foundPrograms.isEmpty {
                        InfoLabel.text?.append("No programs found with the name '\(searchName)'.")
                    } else {
                        for (index, program) in foundPrograms.enumerated() {
                            InfoLabel.text?.append("\(index + 1). Program ID: \(program.program_Id) Name: \(program.name) College ID: \(program.college_Id)\n")
                        }
                    }
                } else {
                    InfoLabel.text = "Invalid input for Program Name. Please try again."
                }
            }
        }
    }

    @objc func searchCrs(sender: UIButton) {
        if let searchItView = window?.viewWithTag(4) {
            if let searchCrsField = searchItView.subviews.first(where: { $0 is UITextField && $0.tag == 1002 }) as? UITextField,
               let InfoLabel = searchItView.subviews.first(where: { $0 is UILabel }) as? UILabel {
                
                if let searchCourseName = searchCrsField.text, !searchCourseName.isEmpty {
                    var foundCourses: [Course] = []

                    for course in MasterOrderCourseList {
                        if course.name.lowercased().contains(searchCourseName.lowercased()) {
                            foundCourses.append(course)
                        }
                    }

                    if foundCourses.isEmpty {
                        InfoLabel.text = "No courses found with the name '\(searchCourseName)'."
                    } else {
                        var courseInfo = "Courses found with the name '\(searchCourseName)':\n"

                        for (index, course) in foundCourses.enumerated() {
                            courseInfo += "\(index + 1). Course ID: \(course.course_Id) Name: \(course.name) College ID: \(course.college_Id) Program ID: \(course.program_Id) Category ID: \(course.category_Id)\n"
                        }
                        
                        InfoLabel.text = courseInfo
                    }
                } else {
                    InfoLabel.text = "Invalid input for Course Name. Please try again."
                }
            }
        }
    }

    @objc func searchCats(sender:UIButton) {
        if let searchItView = window?.viewWithTag(4) {
            if let searchCCField = searchItView.subviews.first(where: { $0 is UITextField && $0.tag == 1003 }) as? UITextField,
               let InfoLabel = searchItView.subviews.first(where: { $0 is UILabel }) as? UILabel {
                if let searchName = searchCCField.text, !searchName.isEmpty {
                    var foundCategories: [Course_Category] = []
                    
                    for category in categories {
                        if category.name.lowercased().contains(searchName.lowercased()) {
                            foundCategories.append(category)
                        }
                    }
                    
                    InfoLabel.text = "Search Information:\n"
                    
                    if foundCategories.isEmpty {
                        InfoLabel.text?.append("No Categories found with the name '\(searchName)'.")
                    } else {
                        InfoLabel.text?.append("Categories found with the name '\(searchName)':\n")
                        for (index, category) in foundCategories.enumerated() {
                            InfoLabel.text?.append("\(index + 1). Category ID: \(category.category_Id)\nName: \(category.name)\n")
                            InfoLabel.text?.append("Courses under this Category name: \(category.name)\n")
                            for course in category.courses {
                                InfoLabel.text?.append("Courses: \(course.name)\n")
                            }
                        }
                    }
                } else {
                    InfoLabel.text = "Invalid input for Category Name. Please try again."
                }
            }
        }
    }

    
  

    @objc func switchToColleges(sender: UIButton) {
      if let selectClgView = sender.superview {
        selectClgView.removeFromSuperview()
        
      }

      // Create the main menu view and add it to the window
      if let manageCollegesView = window?.viewWithTag(2) {
        window?.addSubview(manageCollegesView)
      }
    }
   
  @objc func switchToMainMenu(sender: UIButton) {
    if let manageCollegesView = sender.superview {
      manageCollegesView.removeFromSuperview()
      
    }

    // Create the main menu view and add it to the window
    if let homeView = window?.viewWithTag(1) {
      window?.addSubview(homeView)
    }
  }
   
  @objc func switchtoMngColleges(sender: UIButton) {
    if let addClgView = sender.superview {
      addClgView.removeFromSuperview()
    }

    if let updClgView = sender.superview {
      updClgView.removeFromSuperview()
    }

    // Create the main menu view and add it to the window
    
    if let delClgView = sender.superview {
      delClgView.removeFromSuperview()
    }

    // Create the main menu view and add it to the window
    if let homeView = window?.viewWithTag(1) {
      window?.addSubview(homeView)
    }
  }
   
   
   
  @objc func closeView(sender: UIButton) {

    // Find and remove the errorView from its superview
    for view in window?.subviews ?? [] {
      if view.backgroundColor == UIColor.darkGray {
        // Animate the removal of the error view
        UIView.animate(withDuration: 0.3, animations: {
          view.alpha = 0
        }) { (completed) in
          view.removeFromSuperview()
        }
        break
      }
      if view.tag == 1 {
        UIView.animate(withDuration: 0.3, animations: {
          view.alpha = 0
        }) { (completed) in
          view.removeFromSuperview()
        }
        break
      }
       
    }
     
     
     
  }

   
  func createLoginTextFields() -> (UITextField, UITextField) {
      let usernameTextField = UITextField(frame: CGRect(x: 75.0, y: 350.0, width: 250.0, height: 50.0))
      usernameTextField.textAlignment = NSTextAlignment.center
      usernameTextField.textColor = UIColor.black
      usernameTextField.backgroundColor = UIColor.white
      usernameTextField.borderStyle = UITextField.BorderStyle.roundedRect
      usernameTextField.clearButtonMode = .whileEditing
      usernameTextField.placeholder = "Enter Username"
      usernameTextField.keyboardType = .default
      usernameTextField.returnKeyType = .done

      let passwordTextField = UITextField(frame: CGRect(x: 75.0, y: 410.0, width: 250.0, height: 50.0))
      passwordTextField.textAlignment = NSTextAlignment.center
      passwordTextField.textColor = UIColor.black
      passwordTextField.backgroundColor = UIColor.white
      passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
      passwordTextField.isSecureTextEntry = true // Setting secure text input
      passwordTextField.clearButtonMode = .whileEditing
      passwordTextField.placeholder = "Enter Password"
      passwordTextField.keyboardType = .default
      passwordTextField.returnKeyType = .done

      return (usernameTextField, passwordTextField)
    }
  }

func createAddClgTextFields() -> (UITextField, UITextField, UITextField) {
  let ClgIdField = UITextField(frame: CGRect(x: 75.0, y: 350.0, width: 250.0, height: 50.0))
  ClgIdField.textAlignment = NSTextAlignment.center
  ClgIdField.textColor = UIColor.black
  ClgIdField.backgroundColor = UIColor.white
  ClgIdField.borderStyle = UITextField.BorderStyle.roundedRect
  ClgIdField.clearButtonMode = .whileEditing
  ClgIdField.placeholder = "Enter Collge Id"
  ClgIdField.keyboardType = .default
  ClgIdField.returnKeyType = .done
  ClgIdField.tag = 0
    
  let ClgNameField = UITextField(frame: CGRect(x: 75.0, y: 410.0, width: 250.0, height: 50.0))
  ClgNameField.textAlignment = NSTextAlignment.center
  ClgNameField.textColor = UIColor.black
  ClgNameField.backgroundColor = UIColor.white
  ClgNameField.borderStyle = UITextField.BorderStyle.roundedRect
  ClgNameField.clearButtonMode = .whileEditing
  ClgNameField.placeholder = "Enter College name"
  ClgNameField.keyboardType = .default
  ClgNameField.returnKeyType = .done
    ClgNameField.tag = 1
    
  let ClgAdsField = UITextField(frame: CGRect(x: 75.0, y: 470.0, width: 250.0, height: 50.0))
  ClgAdsField.textAlignment = NSTextAlignment.center
  ClgAdsField.textColor = UIColor.black
  ClgAdsField.backgroundColor = UIColor.white
  ClgAdsField.borderStyle = UITextField.BorderStyle.roundedRect
  ClgAdsField.clearButtonMode = .whileEditing
  ClgAdsField.placeholder = "Enter Address"
  ClgAdsField.keyboardType = .default
  ClgAdsField.returnKeyType = .done
  ClgAdsField.tag = 2
    return (ClgIdField, ClgNameField, ClgAdsField)
  }

func createUpdClgTextFields() -> (UITextField, UITextField, UITextField) {
  let clgIdField = UITextField(frame: CGRect(x: 75, y: 350, width: 250, height: 50))
  clgIdField.textAlignment = NSTextAlignment.center
  clgIdField.textColor = UIColor.black
  clgIdField.backgroundColor = UIColor.white
  clgIdField.borderStyle = UITextField.BorderStyle.roundedRect
  clgIdField.clearButtonMode = .whileEditing
  clgIdField.placeholder = "Enter College ID"
  clgIdField.keyboardType = .numberPad
  clgIdField.returnKeyType = .done
  clgIdField.tag = 0 // Set the tag to identify this text field

  let clgNameField = UITextField(frame: CGRect(x: 75, y: 410, width: 250, height: 50))
  clgNameField.textAlignment = NSTextAlignment.center
  clgNameField.textColor = UIColor.black
  clgNameField.backgroundColor = UIColor.white
  clgNameField.borderStyle = UITextField.BorderStyle.roundedRect
  clgNameField.clearButtonMode = .whileEditing
  clgNameField.placeholder = "Enter College Name"
  clgNameField.keyboardType = .default
  clgNameField.returnKeyType = .done
  clgNameField.tag = 1 // Set the tag to identify this text field

  let clgAddressField = UITextField(frame: CGRect(x: 75, y: 470, width: 250, height: 50))
  clgAddressField.textAlignment = NSTextAlignment.center
  clgAddressField.textColor = UIColor.black
  clgAddressField.backgroundColor = UIColor.white
  clgAddressField.borderStyle = UITextField.BorderStyle.roundedRect
  clgAddressField.clearButtonMode = .whileEditing
  clgAddressField.placeholder = "Enter College Address"
  clgAddressField.keyboardType = .default
  clgAddressField.returnKeyType = .done
  clgAddressField.tag = 2 // Set the tag to identify this text field

  return (clgIdField, clgNameField, clgAddressField)
}

func createSelectField() -> (UITextField) {
    let ClgIdField = UITextField(frame: CGRect(x: 0.0, y: 520.0, width: 70, height: 50.0))
    ClgIdField.textAlignment = NSTextAlignment.center
    ClgIdField.textColor = UIColor.black
    ClgIdField.backgroundColor = UIColor.white
    ClgIdField.borderStyle = UITextField.BorderStyle.roundedRect
    ClgIdField.clearButtonMode = .whileEditing
    ClgIdField.placeholder = "Id"
    ClgIdField.keyboardType = .default
    ClgIdField.returnKeyType = .done
    ClgIdField.tag = 4
    return ClgIdField
}

func createSelectCatField() -> (UITextField){
    let CatIdField = UITextField(frame: CGRect(x: 0.0, y: 520.0, width: 70, height: 50.0))
    CatIdField.textAlignment = NSTextAlignment.center
    CatIdField.textColor = UIColor.black
    CatIdField.backgroundColor = UIColor.white
    CatIdField.borderStyle = UITextField.BorderStyle.roundedRect
    CatIdField.clearButtonMode = .whileEditing
    CatIdField.placeholder = "Id"
    CatIdField.keyboardType = .default
    CatIdField.returnKeyType = .done
    CatIdField.tag = 35
    return CatIdField
    
}

func createAddProTextFields() -> (UITextField, UITextField, UITextField) {
  let ProIdField = UITextField(frame: CGRect(x: 75.0, y: 350.0, width: 250.0, height: 50.0))
    ProIdField.textAlignment = NSTextAlignment.center
    ProIdField.textColor = UIColor.black
    ProIdField.backgroundColor = UIColor.white
    ProIdField.borderStyle = UITextField.BorderStyle.roundedRect
    ProIdField.clearButtonMode = .whileEditing
    ProIdField.placeholder = "Enter Program Id"
    ProIdField.keyboardType = .default
    ProIdField.returnKeyType = .done
    ProIdField.tag = 5
    
  let ProNameField = UITextField(frame: CGRect(x: 75.0, y: 410.0, width: 250.0, height: 50.0))
    ProNameField.textAlignment = NSTextAlignment.center
    ProNameField.textColor = UIColor.black
    ProNameField.backgroundColor = UIColor.white
    ProNameField.borderStyle = UITextField.BorderStyle.roundedRect
    ProNameField.clearButtonMode = .whileEditing
    ProNameField.placeholder = "Enter Program name"
    ProNameField.keyboardType = .default
    ProNameField.returnKeyType = .done
    ProNameField.tag = 6
    
    let clgIdField = UITextField(frame: CGRect(x: 75, y: 470, width: 250, height: 50))
    clgIdField.textAlignment = NSTextAlignment.center
    clgIdField.textColor = UIColor.black
    clgIdField.backgroundColor = UIColor.white
    clgIdField.borderStyle = UITextField.BorderStyle.roundedRect
    clgIdField.clearButtonMode = .whileEditing
    clgIdField.placeholder = "Enter College ID"
    clgIdField.keyboardType = .numberPad
    clgIdField.returnKeyType = .done
    clgIdField.tag = 7
    
    return (ProIdField, ProNameField, clgIdField)
  }

func createUpdProTextFields() -> (UITextField, UITextField, UITextField) {
  let ProIdField = UITextField(frame: CGRect(x: 75.0, y: 350.0, width: 250.0, height: 50.0))
    ProIdField.textAlignment = NSTextAlignment.center
    ProIdField.textColor = UIColor.black
    ProIdField.backgroundColor = UIColor.white
    ProIdField.borderStyle = UITextField.BorderStyle.roundedRect
    ProIdField.clearButtonMode = .whileEditing
    ProIdField.placeholder = "Enter Program Id"
    ProIdField.keyboardType = .default
    ProIdField.returnKeyType = .done
    ProIdField.tag = 8
    
  let ProNameField = UITextField(frame: CGRect(x: 75.0, y: 410.0, width: 250.0, height: 50.0))
    ProNameField.textAlignment = NSTextAlignment.center
    ProNameField.textColor = UIColor.black
    ProNameField.backgroundColor = UIColor.white
    ProNameField.borderStyle = UITextField.BorderStyle.roundedRect
    ProNameField.clearButtonMode = .whileEditing
    ProNameField.placeholder = "Enter Program name"
    ProNameField.keyboardType = .default
    ProNameField.returnKeyType = .done
    ProNameField.tag = 9
    
    let clgIdField = UITextField(frame: CGRect(x: 75, y: 470, width: 250, height: 50))
    clgIdField.textAlignment = NSTextAlignment.center
    clgIdField.textColor = UIColor.black
    clgIdField.backgroundColor = UIColor.white
    clgIdField.borderStyle = UITextField.BorderStyle.roundedRect
    clgIdField.clearButtonMode = .whileEditing
    clgIdField.placeholder = "Enter College ID"
    clgIdField.keyboardType = .numberPad
    clgIdField.returnKeyType = .done
    clgIdField.tag = 10
    
    return (ProIdField, ProNameField, clgIdField)
  }


func createAddCatTextFields() -> (UITextField, UITextField) {
  let CatIdField = UITextField(frame: CGRect(x: 75.0, y: 350.0, width: 250.0, height: 50.0))
    CatIdField.textAlignment = NSTextAlignment.center
    CatIdField.textColor = UIColor.black
    CatIdField.backgroundColor = UIColor.white
    CatIdField.borderStyle = UITextField.BorderStyle.roundedRect
    CatIdField.clearButtonMode = .whileEditing
    CatIdField.placeholder = "Enter Category Id"
    CatIdField.keyboardType = .default
    CatIdField.returnKeyType = .done
    CatIdField.tag = 11
    
  let CatNameField = UITextField(frame: CGRect(x: 75.0, y: 410.0, width: 250.0, height: 50.0))
    CatNameField.textAlignment = NSTextAlignment.center
    CatNameField.textColor = UIColor.black
    CatNameField.backgroundColor = UIColor.white
    CatNameField.borderStyle = UITextField.BorderStyle.roundedRect
    CatNameField.clearButtonMode = .whileEditing
    CatNameField.placeholder = "Enter Category name"
    CatNameField.keyboardType = .default
    CatNameField.returnKeyType = .done
    CatNameField.tag = 12
    
  
    return (CatIdField, CatNameField)
  }

func createUpdCatTextFields() -> (UITextField, UITextField) {
    let CatIdField = UITextField(frame: CGRect(x: 75.0, y: 350.0, width: 250.0, height: 50.0))
      CatIdField.textAlignment = NSTextAlignment.center
      CatIdField.textColor = UIColor.black
      CatIdField.backgroundColor = UIColor.white
      CatIdField.borderStyle = UITextField.BorderStyle.roundedRect
      CatIdField.clearButtonMode = .whileEditing
      CatIdField.placeholder = "Enter Category Id"
      CatIdField.keyboardType = .default
      CatIdField.returnKeyType = .done
      CatIdField.tag = 13
      
    let CatNameField = UITextField(frame: CGRect(x: 75.0, y: 410.0, width: 250.0, height: 50.0))
      CatNameField.textAlignment = NSTextAlignment.center
      CatNameField.textColor = UIColor.black
      CatNameField.backgroundColor = UIColor.white
      CatNameField.borderStyle = UITextField.BorderStyle.roundedRect
      CatNameField.clearButtonMode = .whileEditing
      CatNameField.placeholder = "Enter Category name"
      CatNameField.keyboardType = .default
      CatNameField.returnKeyType = .done
      CatNameField.tag = 14
    return (CatIdField, CatNameField)
  }

func createAddCourseTextFields() -> (UITextField, UITextField, UITextField, UITextField, UITextField) {
    let courseIdField = UITextField(frame: CGRect(x: 75, y: 230, width: 250, height: 50))
    courseIdField.textAlignment = NSTextAlignment.center
    courseIdField.textColor = UIColor.black
    courseIdField.backgroundColor = UIColor.white
    courseIdField.borderStyle = UITextField.BorderStyle.roundedRect
    courseIdField.clearButtonMode = .whileEditing
    courseIdField.placeholder = "Enter Course ID"
    courseIdField.keyboardType = .numberPad
    courseIdField.returnKeyType = .done
    courseIdField.tag = 15

    let courseNameField = UITextField(frame: CGRect(x: 75, y: 290, width: 250, height: 50))
    courseNameField.textAlignment = NSTextAlignment.center
    courseNameField.textColor = UIColor.black
    courseNameField.backgroundColor = UIColor.white
    courseNameField.borderStyle = UITextField.BorderStyle.roundedRect
    courseNameField.clearButtonMode = .whileEditing
    courseNameField.placeholder = "Enter Course Name"
    courseNameField.keyboardType = .default
    courseNameField.returnKeyType = .done
    courseNameField.tag = 16

    let collegeIdField = UITextField(frame: CGRect(x: 75, y: 350, width: 250, height: 50))
    collegeIdField.textAlignment = NSTextAlignment.center
    collegeIdField.textColor = UIColor.black
    collegeIdField.backgroundColor = UIColor.white
    collegeIdField.borderStyle = UITextField.BorderStyle.roundedRect
    collegeIdField.clearButtonMode = .whileEditing
    collegeIdField.placeholder = "Enter College ID"
    collegeIdField.keyboardType = .numberPad
    collegeIdField.returnKeyType = .done
    collegeIdField.tag = 17

    let programIdField = UITextField(frame: CGRect(x: 75, y: 410, width: 250, height: 50))
    programIdField.textAlignment = NSTextAlignment.center
    programIdField.textColor = UIColor.black
    programIdField.backgroundColor = UIColor.white
    programIdField.borderStyle = UITextField.BorderStyle.roundedRect
    programIdField.clearButtonMode = .whileEditing
    programIdField.placeholder = "Enter Program ID"
    programIdField.keyboardType = .numberPad
    programIdField.returnKeyType = .done
    programIdField.tag = 18
    
    let categoryIdField = UITextField(frame: CGRect(x: 75, y: 470, width: 250, height: 50))
    categoryIdField.textAlignment = NSTextAlignment.center
    categoryIdField.textColor = UIColor.black
    categoryIdField.backgroundColor = UIColor.white
    categoryIdField.borderStyle = UITextField.BorderStyle.roundedRect
    categoryIdField.clearButtonMode = .whileEditing
    categoryIdField.placeholder = "Enter Category ID"
    categoryIdField.keyboardType = .numberPad
    categoryIdField.returnKeyType = .done
    categoryIdField.tag = 19


    return (courseIdField, courseNameField, collegeIdField, programIdField, categoryIdField)
}

func createUpdCourseTextFields() -> (UITextField, UITextField, UITextField, UITextField, UITextField) {
    let courseIdField = UITextField(frame: CGRect(x: 75, y: 230, width: 250, height: 50))
    courseIdField.textAlignment = NSTextAlignment.center
    courseIdField.textColor = UIColor.black
    courseIdField.backgroundColor = UIColor.white
    courseIdField.borderStyle = UITextField.BorderStyle.roundedRect
    courseIdField.clearButtonMode = .whileEditing
    courseIdField.placeholder = "Enter Course ID"
    courseIdField.keyboardType = .numberPad
    courseIdField.returnKeyType = .done
    courseIdField.tag = 201

    let courseNameField = UITextField(frame: CGRect(x: 75, y: 290, width: 250, height: 50))
    courseNameField.textAlignment = NSTextAlignment.center
    courseNameField.textColor = UIColor.black
    courseNameField.backgroundColor = UIColor.white
    courseNameField.borderStyle = UITextField.BorderStyle.roundedRect
    courseNameField.clearButtonMode = .whileEditing
    courseNameField.placeholder = "Enter Course Name"
    courseNameField.keyboardType = .default
    courseNameField.returnKeyType = .done
    courseNameField.tag = 202

    let collegeIdField = UITextField(frame: CGRect(x: 75, y: 350, width: 250, height: 50))
    collegeIdField.textAlignment = NSTextAlignment.center
    collegeIdField.textColor = UIColor.black
    collegeIdField.backgroundColor = UIColor.white
    collegeIdField.borderStyle = UITextField.BorderStyle.roundedRect
    collegeIdField.clearButtonMode = .whileEditing
    collegeIdField.placeholder = "Enter College ID"
    collegeIdField.keyboardType = .numberPad
    collegeIdField.returnKeyType = .done
    collegeIdField.tag = 203

    let programIdField = UITextField(frame: CGRect(x: 75, y: 410, width: 250, height: 50))
    programIdField.textAlignment = NSTextAlignment.center
    programIdField.textColor = UIColor.black
    programIdField.backgroundColor = UIColor.white
    programIdField.borderStyle = UITextField.BorderStyle.roundedRect
    programIdField.clearButtonMode = .whileEditing
    programIdField.placeholder = "Enter Program ID"
    programIdField.keyboardType = .numberPad
    programIdField.returnKeyType = .done
    programIdField.tag = 204
    
    let categoryIdField = UITextField(frame: CGRect(x: 75, y: 470, width: 250, height: 50))
    categoryIdField.textAlignment = NSTextAlignment.center
    categoryIdField.textColor = UIColor.black
    categoryIdField.backgroundColor = UIColor.white
    categoryIdField.borderStyle = UITextField.BorderStyle.roundedRect
    categoryIdField.clearButtonMode = .whileEditing
    categoryIdField.placeholder = "Enter Category ID"
    categoryIdField.keyboardType = .numberPad
    categoryIdField.returnKeyType = .done
    categoryIdField.tag = 205

    return (courseIdField, courseNameField, collegeIdField, programIdField, categoryIdField)
}



func createSearchTextFields() -> (UITextField, UITextField, UITextField, UITextField) {
  let searchClgField = UITextField(frame: CGRect(x: 40, y: 70, width: 150, height: 30))
    searchClgField.textAlignment = NSTextAlignment.center
    searchClgField.textColor = UIColor.black
    searchClgField.backgroundColor = UIColor.white
    searchClgField.borderStyle = UITextField.BorderStyle.roundedRect
    searchClgField.clearButtonMode = .whileEditing
    searchClgField.placeholder = "Enter College"
    searchClgField.keyboardType = .default
    searchClgField.returnKeyType = .done
    searchClgField.tag = 1000
    
  let searchProField = UITextField(frame: CGRect(x: 40, y: 110, width: 150, height: 30))
    searchProField.textAlignment = NSTextAlignment.center
    searchProField.textColor = UIColor.black
    searchProField.backgroundColor = UIColor.white
    searchProField.borderStyle = UITextField.BorderStyle.roundedRect
    searchProField.clearButtonMode = .whileEditing
    searchProField.placeholder = "Enter Program name"
    searchProField.keyboardType = .default
    searchProField.returnKeyType = .done
    searchProField.tag = 1001
    
    let searchCrsField = UITextField(frame: CGRect(x: 40, y: 150, width: 150, height: 30))
    searchCrsField.textAlignment = NSTextAlignment.center
    searchCrsField.textColor = UIColor.black
    searchCrsField.backgroundColor = UIColor.white
    searchCrsField.borderStyle = UITextField.BorderStyle.roundedRect
    searchCrsField.clearButtonMode = .whileEditing
    searchCrsField.placeholder = "Enter Course"
    searchCrsField.keyboardType = .numberPad
    searchCrsField.returnKeyType = .done
    searchCrsField.tag = 1002
    
    let searchCCField = UITextField(frame: CGRect(x: 40, y: 190, width: 150, height: 30))
    searchCCField.textAlignment = NSTextAlignment.center
    searchCCField.textColor = UIColor.black
    searchCCField.backgroundColor = UIColor.white
    searchCCField.borderStyle = UITextField.BorderStyle.roundedRect
    searchCCField.clearButtonMode = .whileEditing
    searchCCField.placeholder = "Enter Category"
    searchCCField.keyboardType = .numberPad
    searchCCField.returnKeyType = .done
    searchCCField.tag = 1003
    
    return (searchClgField, searchProField, searchCrsField, searchCCField)
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }




