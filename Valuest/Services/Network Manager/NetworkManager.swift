//
//  NetworkManager.swift
//  Valuest
//
//  Created by Arthur Olevsky on 27.03.2022.
//

import Foundation
import SwiftUI

enum CreateUserErrors: Error {
    case invalidURL
    case userExists
    case unableToCreateUser
    case invalidData
    case invalidResponse
}

enum GetUserError: Error {
    case invalidURL
    case invalidData
    case invalidResponse
    case unableToGetUser
}

final class NetworkManager {
    
    static var shared = NetworkManager()
    
    static let baseURL = "http://95.163.212.53/"
    private let createUserURL = baseURL + "user"
    private let getUserURL = baseURL + "user/"
    
    private init() { }
    
    func createUser(userID: String, fullName: String, email: String, completed: @escaping (Result<Void, CreateUserErrors>) -> Void) {
        // Checking url
        guard let url = URL(string: createUserURL) else {
            completed(.failure(.invalidURL))
            return
        }
        // Constructing request
        let parameters: [String: String] = ["userID": userID, "fullName": fullName, "email": email]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            completed(.failure(.invalidData))
            return
        }
        request.httpBody = httpBody
        request.timeoutInterval = 20
        // Perfom POST request
        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            // Checking errors
            if let _ = error {
                completed(.failure(.unableToCreateUser))
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode == 201 {
                completed(.success(()))
            } else {
                completed(.failure(.invalidResponse))
            }
        }
        task.resume()
    }
    
    func getUser(userID: String, completed: @escaping (Result<User, GetUserError>) -> Void) {
        guard let url = URL(string: getUserURL + userID) else {
            completed(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToGetUser))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(User.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
        
    }
}
