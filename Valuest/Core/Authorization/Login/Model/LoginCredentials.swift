//
//  LoginCredentials.swift
//  Valuest
//
//  Created by Arthur Olevsky on 31.03.2022.
//

import Foundation

struct LoginCredentials {
    var email: String
    var password: String
}

extension LoginCredentials {
    
    static var new: LoginCredentials {
        LoginCredentials(email: "", password: "")
    }
}
