//
//  w6d5_ui_performance_testingUITests.swift
//  w6d5-ui-performance-testingUITests
//
//  Created by Jun Oh on 2019-02-15.
//  Copyright © 2019 Roland. All rights reserved.
//

import XCTest

class w6d5_ui_performance_testingUITests: XCTestCase {

  var app: XCUIApplication!

  override func setUp() {
    app = XCUIApplication()
    app.launch()
    continueAfterFailure = false
  }

  override func tearDown() {
    deleteAllMeals()
  }

  func addMeal(mealName: String, numberOfCalories: Int) {
    app.navigationBars["Master"].buttons["Add"].tap()
    
    let addAMealAlert = app.alerts["Add a Meal"]
    let collectionViewsQuery = addAMealAlert.collectionViews
    var textField = collectionViewsQuery.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
    textField.typeText(mealName)
    textField = collectionViewsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .textField).element
    textField.tap()
    textField.typeText(String(numberOfCalories))
    addAMealAlert.buttons["Ok"].tap()
  }
  
  func deleteMeal(mealName: String, numberOfCalories: Int) {
    let staticText = app.tables.staticTexts[mealName + " - \(numberOfCalories)"]
    if staticText.exists {
      staticText.swipeLeft()
      app.tables.buttons["Delete"].tap()
    }
  }
  
  func showMealDetail(mealName: String, numberOfCalories: Int) {
    let mealText = mealName + " - \(numberOfCalories)"
    let staticText = app.tables.staticTexts[mealText]
    if staticText.exists {
      staticText.tap()
      XCTAssertEqual(app.staticTexts["detailViewControllerLabel"].label, mealText)
      app.navigationBars["Detail"].buttons["Master"].tap()
    }
  }
  
  func deleteAllMeals() {
    for _ in 0..<app.tables.staticTexts.count {
      app.tables.staticTexts.element(boundBy: 0).swipeLeft()
      app.tables.buttons["Delete"].tap()
      sleep(1)
    }
  }
  
  func testAddMeal() {
    addMeal(mealName: "Burger", numberOfCalories: 300)
  }

  func testShowMealDetail() {
    showMealDetail(mealName: "Burger", numberOfCalories: 300)
  }
  
  func testDeleteMeal() {
    deleteMeal(mealName: "Burger", numberOfCalories: 300)
  }
  
  func testDeleteAllMeals() {
    deleteAllMeals()
  }
  
  func testUIPerformanceOperation() {
    self.measure {
      addMeal(mealName: "Burger", numberOfCalories: 300)
      deleteMeal(mealName: "Burger", numberOfCalories: 300)
    }
  }
  
  
}
