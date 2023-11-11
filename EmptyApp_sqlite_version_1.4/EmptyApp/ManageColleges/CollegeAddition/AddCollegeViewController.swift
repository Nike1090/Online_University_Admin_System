//
//  AddCollegeViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/7/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit
import SQLite

class AddCollegeViewController: UIViewController {

    @IBOutlet private var clgIdField: UITextField!
    @IBOutlet private var clgNameField: UITextField!
    @IBOutlet private var clgAddressField: UITextField!

    @IBAction func addCollege(_ sender: UIButton) {
        // Get the college ID, name, and address from the text fields
        guard let clgIdText = clgIdField.text, let clgId = Int(clgIdText),
              let clgName = clgNameField.text, !clgName.isEmpty,
              let clgAddress = clgAddressField.text, !clgAddress.isEmpty else {
            showAlert(message: "Fill all fields and provide valid inputs.")
            return
        }

        do {
            // Access the shared instance of DatabaseManager
            let dbManager = DatabaseManager.shared

            // Retrieve all colleges from the database
            let allColleges = dbManager.retrieveColleges()

            // Check if the college ID already exists in the retrieved colleges
            if allColleges.contains(where: { $0.college_Id == clgId }) {
                showAlert(message: "College with ID \(clgId) already exists. Please choose a different ID.")
            } else {
                // Insert a new college into the database
                try dbManager.db?.run("INSERT INTO colleges (college_Id, name, address) VALUES (?, ?, ?)", clgId, clgName, clgAddress)

                showAlert(message: "\(clgName) added successfully!")
            }
        } catch {
            print("Error adding college: \(error)")
            showAlert(message: "Error adding college. Please try again.")
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
