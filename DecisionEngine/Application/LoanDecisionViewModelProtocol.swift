//
//  LoanDecisionViewModelProtocol.swift
//  DecisionEngine
//
//  Created by Olga Kliushkina on 04.06.2020.
//  Copyright © 2020 Olga Klyushkina. All rights reserved.
//

import Foundation

enum Error {
    case idCodeUnknown, wrongCodeCharsNumber
}

protocol LoanDecisionViewModel {
    var loanPeriodOptions: [Int]? { get }
    var loanAmountOptions: [Int]? { get }
    var errorOccured: ((Error) -> Void)? { get set }
    var loanDecisionCompleted: ((Int) -> Void)? { get set }
    
    func fillLoanOptions()
    func resultForRequest(_ request: LoanRequest)
    
}
