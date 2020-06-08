//
//  LoanDecisionViewModelProtocol.swift
//  DecisionEngine
//
//  Created by Olga Kliushkina on 04.06.2020.
//  Copyright © 2020 Olga Klyushkina. All rights reserved.
//

import Foundation

protocol LoanDecisionViewModel {
    var loanPeriodOptions: [Int]? { get }
    var loanAmountOptions: [Int]? { get }
    var errorOccured: ((IdCodeError) -> Void)? { get set }
    var loanDecisionCompleted: ((Bool, Int) -> Void)? { get set }
    
    func fillLoanOptions()
    func resultForRequest(_ request: LoanRequest)
}
