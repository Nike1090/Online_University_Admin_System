//
//  LoginViewController.swift
//  EmptyApp
//
//  Created by Nikihl kumar on 11/6/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private var usernameField: UITextField!
    @IBOutlet private var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // You can customize the view or add additional setup here if needed.
        
        // Create and configure UI elements programmatically if necessary.
    }
    
    @IBAction private func login() {
        // Handle login logic here using the usernameField and passwordField
        let username = usernameField.text
        let password = passwordField.text
        
        // Perform login validation and transition to the next view as needed.
        
        if isValidLogin(username: username, password: password) {
            // Successful login, perform actions such as transitioning to a different view.
            // Example: Transition to the home view.
            let homeViewController = HomeViewController(nibName: "HomeView", bundle: nil)
            navigationController?.pushViewController(homeViewController, animated: true)

        } else {
            // Show an error message if login fails.
            showErrorAlert(message: "Login failed. Incorrect username or password.")
        }
    }
    
    private func isValidLogin(username: String?, password: String?) -> Bool {
        // Add your login validation logic here.
        // You can check the credentials against your user data or authentication service.
        // For example, compare with your AdminUser instance as in your initial code.
        
        let currentUser = AdminUser(email: "1", password: "1")
        return username == currentUser.email && password == currentUser.password
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
