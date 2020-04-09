//
//  invoiceDataTests.swift
//  Clock-In-OutTests
//
//  Created by Robin Lopez Ordonez on 4/7/20.
//  Copyright © 2020 Robin Lopez Ordonez. All rights reserved.
//

import Foundation
import XCTest

@testable import Clock_In_Out

class invoiceTests: XCTestCase {
    
    let testData = invoiceData(from: Date(), to: Date(), hourly: 5, additional: 5, job: "")
    
    func validJob() {
        XCTAssertFalse(testData.validJob())
    }
}
