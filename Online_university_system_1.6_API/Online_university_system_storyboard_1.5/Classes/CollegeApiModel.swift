//
//  CollegeApiModel.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar on 11/24/23.
//

import Foundation

class CollegeApiModel: Decodable {
    var collegeId: String
    var name: String
    var address: String
    var image: String

    enum CodingKeys: String, CodingKey {
        case collegeId = "id"
        case name
        case address
        case image
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.collegeId = try container.decode(String.self, forKey: .collegeId)
        self.name = try container.decode(String.self, forKey: .name)
        self.address = try container.decode(String.self, forKey: .address)
        self.image = try container.decode(String.self, forKey: .image)
    }

    init(collegeId: String, name: String, address: String, image: String) {
        self.collegeId = collegeId
        self.name = name
        self.address = address
        self.image = image
    }
}
