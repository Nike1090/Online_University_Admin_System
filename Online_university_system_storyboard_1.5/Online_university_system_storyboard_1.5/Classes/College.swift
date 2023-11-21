//
//  College.swift
//  EmptyApp
//
//  Created by Nikihl kumar on 10/28/23.
//  Copyright © 2023 rab. All rights reserved.
//

import Foundation
import UIKit
// Class to represent College
class College {
    var college_Id: Int
    var name: String
    var address: String
    var image: UIImage?
    var programs: [Program] = []
    
    init(college_Id: Int, name: String, address: String,image: UIImage? = nil) {
        self.college_Id = college_Id
        self.name = name
        self.address = address
        self.image = image
    }
}
