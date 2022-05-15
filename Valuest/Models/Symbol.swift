//
//  Symbol.swift
//  Valuest
//
//  Created by Arthur Olevsky on 03.05.2022.
//

import Foundation

struct Symbol: Codable {
    var Code: String
    var Name: String
    var Country: String
    var Exchange: String
    var Currency: String
    var `Type`: String
    var Isin: String?
}
