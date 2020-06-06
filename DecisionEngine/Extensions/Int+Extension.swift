//
//  UIInt+Extension.swift
//  DecisionEngine
//
//  Created by Olga Kliushkina on 06.06.2020.
//  Copyright © 2020 Olga Klyushkina. All rights reserved.
//

import Foundation

extension Int {
    
    func round(to nearest: Int) -> Int {
        return self > 0 ? self.roundPositiveNumber(to: nearest) : self.roundNegativeNumber(to: nearest)
    }
    
}

private extension Int {
    
    func roundPositiveNumber(to nearest: Int) -> Int {
        guard self % nearest > 0 else {
            return self
        }
        
        guard self > nearest else {
            return self >= nearest / 2 ? nearest : 0
        }
        
        let valueToAdd = self % nearest >= nearest / 2 ? nearest : 0
        
        return self / nearest * nearest + valueToAdd
    }
    
    func roundNegativeNumber(to nearest: Int) -> Int {
        guard -self % nearest > 0 else {
            return self
        }
        
        guard -self > nearest else {
            return -self >= nearest / 2 ? -nearest : 0
        }
        
        let valueToAdd = -self % nearest >= nearest / 2 ? -nearest : 0
        
        return self / nearest * nearest + valueToAdd
    }
    
}
