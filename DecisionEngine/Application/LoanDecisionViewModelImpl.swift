//
//  LoanDecisionViewModelImpl.swift
//  DecisionEngine
//
//  Created by Olga Kliushkina on 04.06.2020.
//  Copyright © 2020 Olga Klyushkina. All rights reserved.
//

import Foundation

enum IdCodeError {
    case idCodeUnknown, wrongCodeCharsNumber
}

final class LoanDecisionViewModelImpl: LoanDecisionViewModel {
    
    var loanPeriodOptions: [Int]?
    var loanAmountOptions: [Int]?
    
    var errorOccured: ((IdCodeError) -> Void)?
    var loanDecisionCompleted: ((Bool, Int) -> Void)?
    
    var decisionEngine: DecisionEngine?
    
    init() {
        fillLoanOptions()
        
        self.decisionEngine = DecisionEngine()
    }
    
    func fillLoanOptions() {
        self.loanPeriodOptions = Array(DecisionEngine.minPeriod...DecisionEngine.maxPeriod)
        self.loanAmountOptions = Array(DecisionEngine.minLoanAmount...DecisionEngine.maxLoanAmount).filter { $0 % 100 == 0 }
    }
    
    func resultForRequest(_ request: LoanRequest) {
        guard request.idCode.count == 11 else {
            self.errorOccured?(.wrongCodeCharsNumber)
            return
        }
        
        guard let customer = StubbedData.customersList.filter({ $0.idCode == request.idCode }).first else {
            self.errorOccured?(.idCodeUnknown)
            return
        }
        
        let customerCategory = customer.category
    
        guard let decisionOnLoan = self.decisionEngine?.evaluateLoan(customerCategory: customerCategory, desiredLoanAmount: request.desiredLoanAmount, desiredLoanPeriod: request.desiredLoanPeriod) else { return }
            
        self.loanDecisionCompleted?(decisionOnLoan.isCurrentLoanApprovable, decisionOnLoan.maxLoanSum)
    }
    
}
