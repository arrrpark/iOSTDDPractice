//
//  ItemManagerTest.swift
//  TestDrivenSampleTests
//
//  Created by Arrr Park on 2022/04/26.
//

import XCTest
import CoreLocation
@testable import TestDrivenSample

class ItemManagerTest: XCTestCase {

    var sut: ItemManager!
    
    override func setUpWithError() throws {
        sut = ItemManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testInit_shouldTakeTitle() {
        let item = ToDoItem(title: "Test Title")
        XCTAssertNotNil(item, "item should not be nil")
    }
    
    func testInit_ShouldSetTitleAndDescriptionAndTimestamp() {
        let item = ToDoItem(title: "Test title", itemDescription: "Test Description", timestamp: 0.0)
        XCTAssertEqual(0.0, item.timestamp)
        XCTAssertEqual("Test Description", item.itemDescription)
    }
    
    func testInit_ShouldSetTitleAndDescriptionAndTimestampAndLocation() {
        let location = Location(name: "Test name")
        let item = ToDoItem(title: "Test title", itemDescription: "Test description", timestamp: 0.0, location: location)
        
        XCTAssertEqual(location.name, item.location?.name)
    }
    
    func testInit_ShouldSetNameAndCoordinate() {
        let testCoordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "", coordinate: testCoordinate)
        
        XCTAssertEqual(location.coordinate?.latitude, testCoordinate.latitude)
        XCTAssertEqual(location.coordinate?.longitude, testCoordinate.longitude)
    }
    
    func testToDoCount_Initially_ShouldbeZero() {
        let sut = ItemManager()
        XCTAssertEqual(sut.toDoCount, 0)
    }
    
    func testToDoCOunt_AfterADdOneItem_IsOne() {
        let item = ToDoItem(title: "Test title")

        sut.addItem(item: item)
        XCTAssertEqual(sut.toDoCount, 1)

        let returnedItem = sut.itemAtIndex(0)
        XCTAssertEqual(item.title, returnedItem.title)
    }
    
    func testCheckingItem_ChangesCountOfToDoAndOfDoneItems() {
        sut.addItem(item: ToDoItem(title: "First Item"))
        sut.checkItemAtIndex(0)
        
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 1)
    }
    
    func testCheckingItem_RemovesItFromTheToDoItemList() {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "Second")
        
        sut.addItem(item: firstItem)
        sut.addItem(item: secondItem)
        
        sut.checkItemAtIndex(0)
        
        XCTAssertEqual(sut.itemAtIndex(0).title, secondItem.title)
    }
    
    func testDoneItemAtIndex_ShouldReturnPreviouslyCheckedItem() {
        let item = ToDoItem(title: "Item")
        sut.addItem(item: item)
        sut.checkItemAtIndex(0)
        
        let returnedItem = sut.doneItemAtIndex(0)
        XCTAssertEqual(item.title, returnedItem.title)
    }
    
    func testEqualItems_ShouldNotBeEqual() {
        var firstItem = ToDoItem(title: "First")
        var secondItem = ToDoItem(title: "Second")
        
        firstItem = ToDoItem(title: "First",
                             itemDescription: "First Description",
                             timestamp: 0.0,
                             location: Location(name: "Home"))
        
        secondItem = ToDoItem(title: "Second",
                              itemDescription: "Second Description",
                              timestamp: 0.0,
                              location: Location(name: "Away"))
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testEqualLocations_ShouldBeEqual() {
        let firstLocation = Location(name: "Home")
        let secondLocation = Location(name: "Away")
        
        XCTAssertEqual(firstLocation, secondLocation)
    }
    
    func testEqualLocations_ShouldNotBeEqual() {
        let firstCoordinate = CLLocationCoordinate2D(latitude: 1.0, longitude: 0.0)
        let firstLocation = Location(name: "Home", coordinate: firstCoordinate)
        
        let secondCoordinate = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
        let secondLocation = Location(name: "Away", coordinate: secondCoordinate)
        
        XCTAssertNotEqual(firstLocation, secondLocation)
    }
    
    func testWhenOneLocationIsNilAndTheOtherIsnt_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First Title",
                                 itemDescription: "First description",
                                 timestamp: 0.0,
                                 location: nil)
        
        let secondItem = ToDoItem(title: "First Title",
                                  itemDescription: "First description",
                                  timestamp: 0.0,
                                  location: Location(name: "Home"))
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenTimestampDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First Title",
                                 itemDescription: "First description",
                                 timestamp: 0.0)
        
        let secondItem = ToDoItem(title: "First Title",
                                  itemDescription: "First description",
                                  timestamp: 1.0)
                                 
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenDescriptionDifferes_ShouldNotBeEqual() {
        let firstItem = ToDoItem(title: "First Title",
                                 itemDescription: "First description")
        
        let secondItem = ToDoItem(title: "First Title",
                                  itemDescription: "Second description")
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenTitleDifferes_ShouldNotBeEqual() {
        let firstItem = ToDoItem(title: "First Title")
        
        let secondItem = ToDoItem(title: "Second Title")
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testRemoveAllItems_ShouldResultInCountsBeZero() {
        sut.addItem(item: ToDoItem(title: "First"))
        sut.addItem(item: ToDoItem(title: "Second"))
        
        sut.checkItemAtIndex(0)
        XCTAssertEqual(sut.toDoCount, 1)
        XCTAssertEqual(sut.doneCount, 1)
        
        sut.removeAllItems()
        XCTAssertEqual(sut.toDoCount, 0)
        XCTAssertEqual(sut.doneCount, 0)
    }
}
