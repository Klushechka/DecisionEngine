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
    
    func evaluateLoan(customerCategory: ClientCategory, desiredLoanAmount: Int, desiredLoanPeriod: Int) -> (isCurrentLoanApprovable: Bool, maxLoanSum: Int) {
        let isLoanApprovable = isCurrentLoanApprovable(customerCategory: customerCategory, desiredLoanAmount: desiredLoanAmount, desiredPeriod: desiredLoanPeriod)
        let maxLoanSum = maxLoanAmount(customerCategory: customerCategory, desiredLoanAmount: desiredLoanAmount)
        
        return (isLoanApprovable, maxLoanSum)
    }
    
    func isCurrentLoanApprovable(customerCategory: ClientCategory, desiredLoanAmount: Int, desiredPeriod: Int) -> Bool {
        guard customerCategory != .debt else {
            return false
        }
        
        return creditScore(creditModifier: Float(customerCategory.creditModifier), amount: Float(desiredLoanAmount), period: Float(desiredPeriod)) >= 1
    }
    
    func maxLoanAmount(customerCategory: ClientCategory, desiredLoanAmount: Int) -> Int {
        guard customerCategory != .debt else {
            return 0
        }
        
        let floatAmount = Float(desiredLoanAmount)
        let floatCreditModifier = Float(customerCategory.creditModifier)
        
        let maxPeriodScore = creditScore(creditModifier: floatCreditModifier, amount: floatAmount, period: Float(DecisionEngine.maxPeriod))
        let maxAmount = maxPeriodScore * floatAmount
        let roundedMaxAmount = Int(maxAmount).round(to: 100)
        
        let finalMaxLoanAmount = roundedMaxAmount < DecisionEngine.maxLoanAmount ? roundedMaxAmount : DecisionEngine.maxLoanAmount
        
        return finalMaxLoanAmount
    }
    
    internal func creditScore(creditModifier: Float, amount: Float, period: Float) -> Float {
        return (creditModifier / amount) * period
    }
    
    internal func adjustMaxAmountIfNeeded(with sum: Int) -> Int {
        if sum > DecisionEngine.maxLoanAmount {
            return DecisionEngine.maxLoanAmount
        }
        
        if sum < DecisionEngine.minLoanAmount  {
            return sum.round(to: 1000) == DecisionEngine.minLoanAmount ? DecisionEngine.minLoanAmount : 0
        }
        
        return sum.round(to: 100)
    }
    
}
