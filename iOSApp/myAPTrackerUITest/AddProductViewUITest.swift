//
//  AddProductViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 24/06/22.
//

import XCTest

class AddProductViewUITest: XCTestCase {

    let app = XCUIApplication()
    var userIsNotLogged = false
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app.launch()
        //app.buttons["TrackingTabBar"].tap()
        if (!app.staticTexts["HomeViewLastAddedText"].exists) {
            userIsNotLogged = true
        }
        app.buttons["AmazonTabBar"].tap()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AddProductView_AddButton_Disabled() throws {
        if (userIsNotLogged) {
            let addButton = app.buttons["AddProductViewAddButton"]
            XCTAssertFalse(addButton.isEnabled)
        }
    }
    
    func test_TrackProductView_TrackButton_Disabled() throws {
        if (!userIsNotLogged) {
            let trackButton = app.buttons["AddProductViewTrackButton"]
            XCTAssertFalse(trackButton.isEnabled)
        }
    }
    
    func test_AddProductView_AddButton_Enabled() throws {
        if (userIsNotLogged) {
            let addButton = app.buttons["AddProductViewAddButton"]
            XCTAssertFalse(addButton.isEnabled)
            
            let textField = app.textFields["AddProductViewAmazonTextField"]
            
            textField.tap()
                        
            sleep(5)
            
            textField.typeText("dp/B084DWG2VQ/\n")
            
            app.buttons["AddProductViewAmazonSearch"].tap()
            
            let addButtonNew = app.buttons["AddProductViewAddButton"]
            
            sleep(5)
            
            XCTAssertTrue(addButtonNew.isEnabled)
        }
    }
    
    func test_AddProductView_TrackButton_Enabled() throws {
        if (!userIsNotLogged) {
            let trackButton = app.buttons["AddProductViewTrackButton"]
            XCTAssertFalse(trackButton.isEnabled)
            
            let textField = app.textFields["AddProductViewAmazonTextField"]
            
            textField.tap()
            
            sleep(2)
            
            textField.typeText("dp/B084DWG2VQ/\n")
            
            app.buttons["AddProductViewAmazonSearch"].tap()
            
            let addButtonNew = app.buttons["AddProductViewTrackButton"]
            
            sleep(5)
            
            XCTAssertTrue(addButtonNew.isEnabled)
        }
    }
    
    func test_AddProductView_GoBackAndForwardButton_UserNavigate() throws {
        let backButton = app.buttons["AddProductViewGoBackButton"]
        XCTAssertFalse(backButton.isEnabled)
    
        let forwardButton = app.buttons["AddProductViewGoForwardButton"]
        XCTAssertFalse(forwardButton.isEnabled)
        
        let textField = app.textFields["AddProductViewAmazonTextField"]
        
        textField.tap()
        
        sleep(2)
                
        textField.typeText("dp/B084DWG2VQ/\n")
        
        app.buttons["AddProductViewAmazonSearch"].tap()
        
        let backButtonExist = app.buttons["AddProductViewGoBackButton"].waitForExistence(timeout: 5)
        
        XCTAssertTrue(backButtonExist)
        
        let backButtonNew = app.buttons["AddProductViewGoBackButton"]
        XCTAssertTrue(backButtonNew.isEnabled)
    
        backButtonNew.tap()
        
        let forwardButtonNew = app.buttons["AddProductViewGoForwardButton"]
        XCTAssertTrue(forwardButtonNew.isEnabled)
    }
}


/*extension XCUIElement {
    
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }

        if let placeholderString = self.placeholderValue, placeholderString == stringValue {
            return
        }
        
        var deleteString = String()
        for _ in stringValue {
            deleteString += XCUIKeyboardKey.delete.rawValue
        }
        self.typeText(deleteString)
    }

}*/
