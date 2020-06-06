//
//  IntExtensionTests.swift
//  DecisionEngineTests
//
//  Created by Olga Kliushkina on 04.06.2020.
//  Copyright © 2020 Olga Klyushkina. All rights reserved.
//

import XCTest
@testable import DecisionEngine

class IntExtensionTests: XCTestCase {
    
    func testRoundNinetyNineToHundred() {
        let valueToRound = 99
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), 100)
    }
    
    func testRoundOneToZero() {
        let valueToRound = 1
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), 0)
    }
    
    func testRoundFiftyToHundred() {
        let valueToRound = 50
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), 100)
    }
    
    func testRoundFortyNineToZero() {
        let valueToRound = 49
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), 0)
    }
    
    func testRoundZeroToZero() {
        let valueToRound = 0
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), 0)
    }
    
    func testRoundHundredToHundred() {
        let valueToRound = 100
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), 100)
    }
    
    func testRoundHundredOneToHundred() {
        let valueToRound = 101
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), 100)
    }
    
    func testRoundHundredFortyNineToHundred() {
        let valueToRound = 149
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), 100)
    }
    
    func testRoundHundredFiftyToTwoHundreds() {
        let valueToRound = 150
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), 200)
    }
    
    func testRoundHundredFiftyOneToTwoHundreds() {
        let valueToRound = 151
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), 200)
    }
    
    func testRoundHundredNinetyNineToTwoHundreds() {
        let valueToRound = 199
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), 200)
    }
    
    func testRoundMinusOneToZero() {
        let valueToRound = -1
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), 0)
    }
    
    func testRoundMinusFortyNineToZero() {
        let valueToRound = -49
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), 0)
    }
    
    func testRoundMinusFiftyToMinushundred() {
        let valueToRound = -50
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), -100)
    }
    
    func testRoundMinusNinetyNineToMinusHundred() {
        let valueToRound = -99
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), -100)
    }
    
    func testRoundMinusHundredToMinusHundred() {
        let valueToRound = -100
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), -100)
    }
    
    func testRoundMinusHundredOneToMinusHundred() {
        let valueToRound = -101
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), -100)
    }
    
    func testRoundMinusHundredFortyNineToMinusHundred() {
        let valueToRound = -149
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), -100)
    }
    
    func testRoundMinusHundredFiftyToMinusTwoHundreds() {
        let valueToRound = -150
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), -200)
    }
    
    func testRoundMinusHundredNinetyNineToMMinusTwoHundreds() {
        let valueToRound = -199
        let nearestValue = 100
        
        XCTAssertEqual(valueToRound.round(to: nearestValue), -200)
    }
            
}
