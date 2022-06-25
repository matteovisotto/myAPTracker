//
//  ProductViewUITest.swift
//  myAPTrackerUITest
//
//  Created by Tia on 24/06/22.
//

import XCTest

class ProductViewUITest: XCTestCase {

    let app = XCUIApplication()
    var userIsLogged = true
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        app.buttons["HomeTabBar"].tap()
        if (!app.staticTexts["HomeViewLastAddedText"].waitForExistence(timeout: 2)) {
            userIsLogged = false
        }
        app.scrollViews.otherElements.scrollViews.otherElements.buttons.element(boundBy: 1).tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_ProductView_MaxAndMinTexts_CheckThatMaximumPriceIsHigherThanMinimum() {
        let elementsQuery = app.otherElements
        let priceButton = elementsQuery.buttons.element(boundBy: 1)
        priceButton.tap()
        
        XCTAssertTrue(priceButton.exists)
        
        let highestPrice = app.otherElements.staticTexts["ProductViewHighestPrice"]
        let lowestPrice = app.otherElements.staticTexts["ProductViewLowestPrice"]
                
        XCTAssertTrue(highestPrice.exists)
        XCTAssertTrue(lowestPrice.exists)
        
        let highestPriceValue: Double = Double(highestPrice.label) ?? 0
        let lowestPriceValue: Double = Double(lowestPrice.label) ?? 0
        
        XCTAssertTrue(highestPriceValue >= lowestPriceValue)
    }
    
    func test_ProductView_DetailButton_CorrectlyMoveToDetailPage() {
        let elementsQuery = app.otherElements
        let detailButton = elementsQuery.buttons.element(boundBy: 2)
        detailButton.tap()
        
        XCTAssertTrue(detailButton.exists)
        
        let name = app.otherElements.scrollViews.staticTexts["DetailViewName"]
        let category = app.otherElements.scrollViews.staticTexts["DetailViewCategory"]
        let description = app.otherElements.scrollViews.staticTexts["DetailViewDescription"]
                
        XCTAssertTrue(name.exists)
        XCTAssertTrue(category.exists)
        XCTAssertTrue(description.exists)
    }
    
    func test_ProductView_CommentButton_CorrectlyMoveToCommentPageAndCheckIfTextFieldIsVisble() {
        if (userIsLogged) {
            let elementsQuery = app.otherElements
            let commentButton = elementsQuery.buttons.element(boundBy: 3)
            commentButton.tap()
            
            XCTAssertTrue(commentButton.exists)
            
            let commentTextField = app.otherElements.scrollViews.textFields["CommentViewCommentTextField"]
            XCTAssertTrue(commentTextField.exists)
        }
    }
    
    func test_ProductView_CommentButton_CorrectlyMoveToCommentPageAndCheckThatTextFieldIsNotVisible() {
        if (!userIsLogged) {
            let elementsQuery = app.otherElements
            let commentButton = elementsQuery.buttons.element(boundBy: 3)
            commentButton.tap()
            
            XCTAssertTrue(commentButton.exists)
            
            let commentTextField = app.otherElements.scrollViews.textFields["CommentViewCommentTextField"]
            XCTAssertFalse(commentTextField.exists)
        }
    }
    
    func test_ProductView_TrackingSettingsOptionsButton_OpenSettings() {
        app.buttons["ProductViewSettingsTrackingButton"].tap()
        if (app.buttons["ProductViewSettingsButton"].exists){
            app.buttons["ProductViewSettingsButton"].tap()
        }
        let text = app.scrollViews.staticTexts["UpdateTrackingViewNotificationText"]
        XCTAssertTrue(text.exists)
    }
    
    func test_ProductView_TrackingSettingsOptionsButton_OpenSettingsAndExits() {
        app.buttons["ProductViewSettingsTrackingButton"].tap()
        if (app.buttons["ProductViewSettingsButton"].exists){
            app.buttons["ProductViewSettingsButton"].tap()
        }
        let text = app.scrollViews.staticTexts["UpdateTrackingViewNotificationText"]
        XCTAssertTrue(text.exists)
        
        //Close the settings
        let topOffset = CGVector(dx: 0.5, dy: 0.95)
        let bottomOffset = CGVector(dx: 0.5, dy: 0.15)

        let cellFarRightCoordinate = app.coordinate(withNormalizedOffset: topOffset)
        let cellFarLeftCoordinate = app.coordinate(withNormalizedOffset: bottomOffset)

        // drag from right to left to delete
        cellFarLeftCoordinate.press(forDuration: 0.1, thenDragTo: cellFarRightCoordinate)
                
        sleep(5)
        
        let openSettingsButton = app.buttons["ProductViewSettingsTrackingButton"]
        XCTAssertTrue(openSettingsButton.exists)
    }
    
    func test_ProductView_TrackingSettings_NeverTab() {
        app.buttons["ProductViewSettingsTrackingButton"].tap()
        if (app.buttons["ProductViewSettingsButton"].exists){
            app.buttons["ProductViewSettingsButton"].tap()
        }
        let neverButton = app.scrollViews.buttons["UpdateTrackingViewNeverButton"]
        XCTAssertTrue(neverButton.exists)
        
        neverButton.tap()
        
        let neverText = app.scrollViews.staticTexts["UpdateTrackingViewNeverNotificationText"]
        
        XCTAssertTrue(neverText.exists)
    }
    
    func test_ProductView_TrackingSettings_PercentageTab() {
        app.buttons["ProductViewSettingsTrackingButton"].tap()
        if (app.buttons["ProductViewSettingsButton"].exists){
            app.buttons["ProductViewSettingsButton"].tap()
        }
        let percentageButton = app.scrollViews.buttons["UpdateTrackingViewPercentageButton"]
        XCTAssertTrue(percentageButton.exists)
        
        percentageButton.tap()
        
        let percentageText = app.scrollViews.staticTexts["UpdateTrackingViewPercentageNotificationText"]
        
        XCTAssertTrue(percentageText.exists)
    }
    
    func test_ProductView_TrackingSettings_ValueTab() {
        app.buttons["ProductViewSettingsTrackingButton"].tap()
        if (app.buttons["ProductViewSettingsButton"].exists){
            app.buttons["ProductViewSettingsButton"].tap()
        }
        let valueButton = app.scrollViews.buttons["UpdateTrackingViewValueButton"]
        XCTAssertTrue(valueButton.exists)
        
        valueButton.tap()
        
        let valueText = app.scrollViews.staticTexts["UpdateTrackingViewValueNotificationText"]
        
        XCTAssertTrue(valueText.exists)
    }
    
    func test_ProductView_TrackingSettings_AlwaysTab() {
        app.buttons["ProductViewSettingsTrackingButton"].tap()
        if (app.buttons["ProductViewSettingsButton"].exists){
            app.buttons["ProductViewSettingsButton"].tap()
        }
        let alwaysButton = app.scrollViews.buttons["UpdateTrackingViewAlwaysButton"]
        XCTAssertTrue(alwaysButton.exists)
        
        alwaysButton.tap()
        
        let alwaysText = app.scrollViews.staticTexts["UpdateTrackingViewAlwaysNotificationText"]
        
        XCTAssertTrue(alwaysText.exists)
    }
    
    func test_ProductView_TrackingSettingsOptionsButton_UserStopTrackingOrStartTrackingButton() {
        app.buttons["ProductViewSettingsTrackingButton"].tap()
        if (app.buttons["ProductViewSettingsButton"].exists){
            let stopTrackProduct = app.buttons["ProductViewStopTrackProduct"]
            XCTAssertTrue(stopTrackProduct.exists)
        } else {
            let startTrackProduct = app.buttons["ProductViewStartTrackProduct"]
            XCTAssertTrue(startTrackProduct.exists)
        }
    }
}