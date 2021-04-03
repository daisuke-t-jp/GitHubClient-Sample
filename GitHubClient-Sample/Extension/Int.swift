//
//  Int.swift
//  GitHubClient-Sample
//
//  Created by Daisuke TONOSAKI on 2021/04/01.
//

import Foundation

extension Int {
    
    var shortString: String {
        if self < 1_000 {
            return String(self)
        } else if self < 100_000,
                self % 1_000 >= 100 {
            return String(format: "%.1fk", Float(self) / 1_000)
        }
        
        return String("\(self / 1_000)k")
    }
    
}
