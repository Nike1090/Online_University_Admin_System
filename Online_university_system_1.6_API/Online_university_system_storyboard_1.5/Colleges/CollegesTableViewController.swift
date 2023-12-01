//
//  CollegesTableViewController.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar on 11/17/23.
//

import UIKit


class CollegesTableViewController: UITableViewController {

    var colleges: [College] = []
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Populate 'colleges' array with data retrieved from DatabaseManager
        colleges = DatabaseManager.shared.retrieveColleges()
    
        // Register the UITableViewCell subclass or reuse identifier
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CollegeCell")
        

         
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload table data to reflect any changes (e.g., new college added)
        colleges = DatabaseManager.shared.retrieveColleges()
        tableView.reloadData()
    }

    
   

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 // Assuming a single section for colleges
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollegeCell", for: indexPath)
        
        let college = colleges[indexPath.row]
        cell.textLabel?.text = "\(college.college_Id) - \(college.name) -\(college.address)"
        
        if let collegeImage = college.image {
            
            cell.imageView?.image = collegeImage // Set college image to the cell's imageView
        } else {
            // If college.image is nil, you can set a placeholder image or default image
            cell.imageView?.image = UIImage(named: "dd.jpg") // Replace "placeholder_image" with your default image
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let collegeToRemove = colleges[indexPath.row]
            let collegeId = collegeToRemove.college_Id
            
            // Retrieve programs associated with the college
            let programs = DatabaseManager.shared.retrievePrograms().filter { $0.college_Id == collegeId }

            if programs.isEmpty {
                // Delete the corresponding data from DatabaseManager
                DatabaseManager.shared.deleteCollege(collegeToRemove)

                // Remove the item from the data source
                colleges.remove(at: indexPath.row)

                // Delete the row from the table view
                tableView.deleteRows(at: [indexPath], with: .fade)
                
                showAlert(message: "College deleted successfully!")
            } else {
                showAlert(message: "Cannot delete. College has associated programs.")
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
            performSegue(withIdentifier: "CollegesUpdateViewController", sender: self)
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CollegesUpdateViewController" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let college = colleges[indexPath.row]
                if let updateCollegeVC = segue.destination as? CollegesUpdateViewController {
                    updateCollegeVC.collegeIdInt = college.college_Id
                    updateCollegeVC.collegeNameText = college.name
                    updateCollegeVC.collegeAddressText = college.address
                    updateCollegeVC.collegeImg = college.image
                }
            }
        }
    }


}
