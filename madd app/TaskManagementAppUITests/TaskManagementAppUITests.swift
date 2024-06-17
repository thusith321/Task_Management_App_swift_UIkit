//
//  madd_appTests.swift
//  madd appTests
//
//  Created by Thusith Hettiarachchi on 2024-04-19.
//

import XCTest

final class TaskManagementAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample()  {
        
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["Tasks"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.cells.containing(.staticText, identifier:"Implement this Page").staticTexts["Type      :"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["  Update Task"]/*[[".buttons[\"  Update Task\"].staticTexts[\"  Update Task\"]",".staticTexts[\"  Update Task\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let enterTaskTypeTextField = app.textFields["Enter Task Type"]
        enterTaskTypeTextField.tap()
        app.buttons["  Update Task"].tap()
        
        let backButton = app.navigationBars["TaskManagementApp.SpecificTaskView"].buttons["Back"]
        backButton.tap()
        enterTaskTypeTextField.tap()
        app.navigationBars["TaskManagementApp.EditTaskView"].buttons["Back"].tap()
        backButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"Implement this Page")/*[[".cells.containing(.staticText, identifier:\"Task \")",".cells.containing(.staticText, identifier:\"Implement this Page\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.staticTexts["Duration  : "].tap()
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
