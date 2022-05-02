//
//  ImteListViewControllerTests.swift
//  TestDrivenSampleTests
//
//  Created by Arrr Park on 2022/05/01.
//

import XCTest
import CoreLocation
@testable import TestDrivenSample

class ItemListViewControllerTest: XCTestCase {
    var sut: ItemListViewController!
    
    override func setUpWithError() throws {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyBoard.instantiateViewController(withIdentifier: "ItemListViewController") as? ItemListViewController
        
        _ = sut.view
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_TableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(sut.tableView)
        
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertTrue(sut.tableView.dataSource is ItemListDataProvider)
    }
    
    func testViewDidLoad_ShouldSetTableViewDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is ItemListDataProvider)
    }
    
    func testNumberOfSections_IsTwo() {
        let sut = ItemListDataProvider()
        
        let tableView = UITableView()
        tableView.dataSource = sut
        
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func testNumberRowsInFirstSection_IsToDoCount() {
        let sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let tableView = UITableView()
        tableView.dataSource = sut
        tableView.delegate = sut
        
        sut.itemManager?.addItem(item: ToDoItem(title: "First"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 1)
        
        sut.itemManager?.addItem(item: ToDoItem(title: "Second"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testNumberRowsInSecondSection_IsDoneCount() {
        let sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let tableView = UITableView()
        tableView.dataSource = sut
        tableView.delegate = sut
        
        sut.itemManager?.addItem(item: ToDoItem(title: "First"))
        sut.itemManager?.addItem(item: ToDoItem(title: "Second"))
        sut.itemManager?.checkItemAtIndex(0)
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 1)
        
        sut.itemManager?.checkItemAtIndex(0)
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
}
