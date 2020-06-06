//
//  ClientCategory.swift
//  DecisionEngine
//
//  Created by Olga Kliushkina on 05.06.2020.
//  Copyright © 2020 Olga Klyushkina. All rights reserved.
//

import Foundation

enum ClientCategory {
    
    case debt, firstSegment, secongSegment, thirdSegment
    
    var creditModifier: Int {
        switch self {
        case .firstSegment: return 100
        case .secongSegment: return 300
        case .thirdSegment: return 1000
        default: break
        }
        
        return 0
    }
    
}
