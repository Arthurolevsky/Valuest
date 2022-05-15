//
//  FinancialDataManager.swift
//  Valuest
//
//  Created by Arthur Olevsky on 03.05.2022.
//

import Foundation

enum FinancialDataManagerErrors: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}

final class FinancialDataManager {
    
    static let shared = FinancialDataManager()
    
    private let token = "5d0de5df97e648.40806239"
    private let rootURL = "https://eodhistoricaldata.com/api/"
    
    private init() { }
    
    // MARK: Fetch Symbols List
    /// Function fetches symbols list based on EOD exchange code
    /// - Parameter exchange: EOD exchnage code
    /// - Returns: List of EOD symbols
    func getSymbols(from exchange: String) async throws -> [Symbol] {
        
        // Verify URL
        guard let url = URL(string: "\(rootURL)exchange-symbol-list/\(exchange)?api_token=\(token)&fmt=json") else { throw FinancialDataManagerErrors.invalidURL }
        
        // Perform request
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Verify respose
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FinancialDataManagerErrors.invalidResponse
        }
        
        // Decode data
        do {
            let decoder = JSONDecoder()
            let decodedResponse = try decoder.decode([Symbol].self, from: data)
            return decodedResponse
        } catch {
            throw FinancialDataManagerErrors.invalidData
        }
    }
}
