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
    
    func testMaxLoanForCustomerWithDebt() {
        let maxLoanAmount = self.decisionEngine.evaluateLoan(customerCategory: .debt, desiredLoanAmount: 5100)
        
        XCTAssertEqual(maxLoanAmount, 0)
    }
    
    func testMaxLoanForFirstSegmentCustomer() {
        let maxLoanAmount = self.decisionEngine.evaluateLoan(customerCategory: .firstSegment, desiredLoanAmount: DecisionEngine.maxLoanAmount)
        
        XCTAssertEqual(maxLoanAmount, 6000)
    }
    
    func testMaxLoanForSecondSegmentCustomer() {
        let maxLoanAmount = self.decisionEngine.evaluateLoan(customerCategory: .secondSegment, desiredLoanAmount: DecisionEngine.minLoanAmount)
        
        XCTAssertEqual(maxLoanAmount, DecisionEngine.maxLoanAmount)
    }
    
    func testMaxLoanForThirdSegmentCustomer() {
        let maxLoanAmount = self.decisionEngine.evaluateLoan(customerCategory: .thirdSegment, desiredLoanAmount: 9000)
        
        XCTAssertEqual(maxLoanAmount, DecisionEngine.maxLoanAmount)
    }
    
    func testMaxLoanWithUnroundedDesiredLoanAmount() {
        let maxLoanAmount = self.decisionEngine.evaluateLoan(customerCategory: .secondSegment, desiredLoanAmount: 5749)
        
        XCTAssertEqual(maxLoanAmount, DecisionEngine.maxLoanAmount)
    }
    
    func testRoundingAmountBiggerThanMax() {
        let roundedMaxAmount = self.decisionEngine.maxAmount(with: 18000)
        
        XCTAssertEqual(roundedMaxAmount, DecisionEngine.maxLoanAmount)
    }
    
    func testRoundingAmountLessThanMax() {
        let roundedMaxAmount = self.decisionEngine.maxAmount(with: 5449)
        
        XCTAssertEqual(roundedMaxAmount, 5400)
    }
    
    func testRoundingAmountLessThanMinToMin() {
        let roundedMaxAmount = self.decisionEngine.maxAmount(with: 1500)
        
        XCTAssertEqual(roundedMaxAmount, DecisionEngine.minLoanAmount)
    }
    
    func testRoundingAmountLessThanMinToZero() {
        let roundedMaxAmount = self.decisionEngine.maxAmount(with: 1449)
        
        XCTAssertEqual(roundedMaxAmount, 0)
    }
    
    func testRoundindRoundedAmountBetweenMinAndMaxToItself() {
        let amountToRound = 6100
        let roundedMaxAmount = self.decisionEngine.maxAmount(with: amountToRound)
        
        XCTAssertEqual(roundedMaxAmount, amountToRound)
    }

}
