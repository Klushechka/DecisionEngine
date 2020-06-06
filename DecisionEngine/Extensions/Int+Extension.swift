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
        guard self % nearest > 0 else {
            return self
        }
        
        return self / nearest * nearest
    }
    
}
