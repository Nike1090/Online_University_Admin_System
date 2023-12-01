//
//  CollegesApiTableTableViewController.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar on 11/24/23.
//

import UIKit

class CollegesApiTableTableViewController: UITableViewController {
    var colleges: [CollegeApiModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CollegeCell")
        fetchColleges()
    }
    
    func fetchColleges() {
        NetworkManager.shared.fetchColleges { [weak self] result in
            switch result {
            case .success(let fetchedColleges):
                self?.colleges = fetchedColleges
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching colleges: \(error)")
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colleges.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollegeCell", for: indexPath)
        let college = colleges[indexPath.row]
        cell.textLabel?.text = "\(college.collegeId) - \(college.name) University - \(college.address)"
        
        if let imageURL = URL(string: college.image) {
                    DispatchQueue.global().async {
                        if let imageData = try? Data(contentsOf: imageURL),
                           let image = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                if let visibleIndexPaths = tableView.indexPathsForVisibleRows,
                                   visibleIndexPaths.contains(indexPath) {
                                    cell.imageView?.image = image
                                    cell.setNeedsLayout()
                                }
                            }
                        }
                    }
                }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
        }

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                // Delete the row from the data source
                colleges.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
}
