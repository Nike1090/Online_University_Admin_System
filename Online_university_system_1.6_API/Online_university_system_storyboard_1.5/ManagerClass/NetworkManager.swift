//
//  NetworkManager.swift
//  Online_university_system_storyboard_1.5
//
//  Created by Nikhil kumar on 11/24/23.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager() // Singleton instance

    private let baseURL = "https://65611885dcd355c08323a11e.mockapi.io/api/v6/Colleges"

    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingError
    }

    func fetchColleges(completion: @escaping (Result<[CollegeApiModel], Error>) -> Void) {
        guard let url = URL(string: baseURL) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
//            if let jsonString = String(data: data, encoding: .utf8) {
//                           print("Received JSON Data: \(jsonString)")
//                       }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase // Adjust decoding strategy if needed
                let colleges = try decoder.decode([CollegeApiModel].self, from: data)
                completion(.success(colleges))
            } catch {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
}
