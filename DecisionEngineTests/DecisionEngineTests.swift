//
//  DecisionEngineTests.swift
//  DecisionEngineTests
//
//  Created by Olga Kliushkina on 07.06.2020.
//  Copyright © 2020 Olga Klyushkina. All rights reserved.
//

import XCTest
@testable import DecisionEngine

class DecisionEngineTests: XCTestCase {
    
    var decisionEngine: DecisionEngine!
    
    override func setUp() {
        super.setUp()
        
        self.decisionEngine = DecisionEngine()
    }
    
    func testLoanUnapprovableForCustomerWithDebt() {
        let loanDecision = self.decisionEngine.isCurrentLoanApprovable(customerCategory: .debt, desiredLoanAmount: 3000, desiredPeriod: 15)
        
        XCTAssertEqual(loanDecision, false)
    }
    
    func testLoanUnaprovableForFirstSegmentWithShortPeriod() {
        let loanDecision = self.decisionEngine.isCurrentLoanApprovable(customerCategory: .firstSegment, desiredLoanAmount: DecisionEngine.minLoanAmount, desiredPeriod: DecisionEngine.minPeriod)
        
        XCTAssertEqual(loanDecision, false)
    }
    
    func testLoanIsUnapprovableWithScoreAlmostOne() {
        let loanDecision = self.decisionEngine.isCurrentLoanApprovable(customerCategory: .firstSegment, desiredLoanAmount: DecisionEngine.minLoanAmount, desiredPeriod: 19)
        
        XCTAssertEqual(loanDecision, false)
    }
    
    func testLoanApprovableWithScoreOne() {
        let loanDecision = self.decisionEngine.isCurrentLoanApprovable(customerCategory: .firstSegment, desiredLoanAmount: DecisionEngine.minLoanAmount, desiredPeriod: 20)
        
        XCTAssertEqual(loanDecision, true)
    }
    
    func testMaxLoanForCustomerWithDebt() {
        let maxLoanAmount = self.decisionEngine.maxLoanAmount(customerCategory: .debt, desiredLoanAmount: 5100)
        
        XCTAssertEqual(maxLoanAmount, 0)
    }
    
    func testMaxLoanForFirstSegmentCustomer() {
        let maxLoanAmount = self.decisionEngine.maxLoanAmount(customerCategory: .firstSegment, desiredLoanAmount: DecisionEngine.maxLoanAmount)
        
        XCTAssertEqual(maxLoanAmount, 6000)
    }
    
    func testMaxLoanForSecondSegmentCustomer() {
        let maxLoanAmount = self.decisionEngine.maxLoanAmount(customerCategory: .secondSegment, desiredLoanAmount: DecisionEngine.minLoanAmount)
        
        XCTAssertEqual(maxLoanAmount, DecisionEngine.maxLoanAmount)
    }
    
    func testMaxLoanForThirdSegmentCustomer() {
        let maxLoanAmount = self.decisionEngine.maxLoanAmount(customerCategory: .thirdSegment, desiredLoanAmount: 9000)
        
        XCTAssertEqual(maxLoanAmount, DecisionEngine.maxLoanAmount)
    }
    
    func testMaxLoanWithUnroundedDesiredLoanAmount() {
        let maxLoanAmount = self.decisionEngine.maxLoanAmount(customerCategory: .secondSegment, desiredLoanAmount: 5749)
        
        XCTAssertEqual(maxLoanAmount, DecisionEngine.maxLoanAmount)
    }
    
    func testRoundingAmountBiggerThanMax() {
        let roundedMaxAmount = self.decisionEngine.adjustMaxAmountIfNeeded(with: 18000)
        
        XCTAssertEqual(roundedMaxAmount, DecisionEngine.maxLoanAmount)
    }
    
    func testRoundingAmountLessThanMax() {
        let roundedMaxAmount = self.decisionEngine.adjustMaxAmountIfNeeded(with: 5449)
        
        XCTAssertEqual(roundedMaxAmount, 5400)
    }
    
    func testRoundingAmountLessThanMinToMin() {
        let roundedMaxAmount = self.decisionEngine.adjustMaxAmountIfNeeded(with: 1500)
        
        XCTAssertEqual(roundedMaxAmount, DecisionEngine.minLoanAmount)
    }
    
    func testRoundingAmountLessThanMinToZero() {
        let roundedMaxAmount = self.decisionEngine.adjustMaxAmountIfNeeded(with: 1449)
        
        XCTAssertEqual(roundedMaxAmount, 0)
    }
    
    func testRoundindRoundedAmountBetweenMinAndMaxToItself() {
        let amountToRound = 6100
        let roundedMaxAmount = self.decisionEngine.adjustMaxAmountIfNeeded(with: amountToRound)
        
        XCTAssertEqual(roundedMaxAmount, amountToRound)
    }

}
