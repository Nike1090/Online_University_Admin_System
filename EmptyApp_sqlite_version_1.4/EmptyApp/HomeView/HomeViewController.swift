//
//  HomeViewController.swift
//  EmptyApp
//
//  Created by Nikhil kumar on 11/6/23.
//  Copyright © 2023 rab. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // You can customize the view or add additional setup here if needed.
    }
    
    @IBAction func manageColleges(_ sender: UIButton) {
        let manageCollegesViewController = ManageCollegesViewController(nibName: "ManageCollegesView", bundle: nil)
        navigationController?.pushViewController(manageCollegesViewController, animated: true)
    }
    
    @IBAction func manageCourseCategory(_ sender: UIButton) {
        let manageCCViewController = ManageCCViewController(nibName: "ManageCCView", bundle: nil)
        navigationController?.pushViewController(manageCCViewController, animated: true)
    }
    
    @IBAction func searchBy(_ sender: UIButton) {
        let searchViewController = SearchViewController(nibName: "SearchView", bundle: nil)
        navigationController?.pushViewController(searchViewController, animated: true)
    }
    

}
