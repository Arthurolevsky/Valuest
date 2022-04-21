//
//  HideKeyboard.swift
//  Valuest
//
//  Created by Arthur Olevsky on 17.03.2022.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
