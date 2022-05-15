//
//  Array.swift
//  Valuest
//
//  Created by Arthur Olevsky on 01.05.2022.
//

import SwiftUI


extension Array where Element == CGFloat {
    
    var normalized: [CGFloat] {
        if let min = self.min(), let max = self.max() {
            return self.map { ($0 - min) / (max - min) }
        }
        return []
    }
}
