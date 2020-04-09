//
//  Clock_In_OutUITests.swift
//  Clock-In-OutUITests
//
//  Created by Robin Lopez Ordonez on 3/3/20.
//  Copyright © 2020 Robin Lopez Ordonez. All rights reserved.
//

import XCTest

class Clock_In_OutUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidClock() {
        let app = XCUIApplication()
        app.tabBars.buttons["Clock"].tap()
        app.buttons["Clock In"].tap()
        app.buttons["Clock Out"].tap()
        
        
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
