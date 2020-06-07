//
//  DecisionEngine.swift
//  DecisionEngine
//
//  Created by Olga Kliushkina on 05.06.2020.
//  Copyright © 2020 Olga Klyushkina. All rights reserved.
//

import Foundation

final class DecisionEngine {
    
    static let minPeriod = 12
    static let maxPeriod = 60
    
    static let minLoanAmount = 2000
    static let maxLoanAmount = 10000
    
    func evaluateLoan(for customerCategory: ClientCategory, with request: LoanRequest) -> Int {
        guard customerCategory != .debt else {
            return 0
        }
        
        let floatAmount = Float(request.desiredLoanAmount)
        let floatCreditModifier = Float(customerCategory.creditModifier)
        
        let maxPeriodScore = creditScore(creditModifier: floatCreditModifier, amount: floatAmount, period: Float(DecisionEngine.maxPeriod))
        let maxAmount = maxPeriodScore * floatAmount
        let roundedMaxAmount = Int(maxAmount).round(to: 100)
        
        let finalMaxLoanAmount = roundedMaxAmount < DecisionEngine.maxLoanAmount ? roundedMaxAmount : DecisionEngine.maxLoanAmount
        
        return finalMaxLoanAmount
    }
    
    func creditScore(creditModifier: Float, amount: Float, period: Float) -> Float {
        return creditModifier / amount * period
    }
    
    func maxAmount(with sum: Int) -> Int {
        if sum > DecisionEngine.maxLoanAmount {
            return DecisionEngine.maxLoanAmount
        }
        
        return sum.round(to: 100)
    }
    
}
