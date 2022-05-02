//
//  ItemCellTests.swift
//  TestDrivenSampleTests
//
//  Created by Arrr Park on 2022/05/02.
//

import XCTest
import CoreLocation
@testable import TestDrivenSample

class ItemCellTests: XCTestCase {
    var sut: ItemListDataProvider!
    var tableView: UITableView!
    var controller: ItemListViewController!
    
    override func setUpWithError() throws {
        sut = ItemListDataProvider()
        sut.itemManager = ItemManager()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyBoard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        
        _ = controller.view
        tableView = controller.tableView
        tableView.delegate = sut
        tableView.dataSource = sut
    }

    override func tearDownWithError() throws {
        sut = nil
        tableView = nil
        controller = nil
    }
    
    func testSUT_HasLabels() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ItemListViewController") as! ItemListViewController
        
        _ = controller.view
        
        let tableView = controller.tableView
        tableView?.dataSource = FakeDataSource()
        
        let cell = tableView?.dequeueReusableCell(withIdentifier: String(describing: ItemCell.self), for: IndexPath(row: 0, section: 0)) as! ItemCell
        
        XCTAssertNotNil(cell.titleLabel)
        XCTAssertNotNil(cell.locationLabel)
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func testConfigWithItem_SetsLabelTexts() {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemCell.self), for: IndexPath(row: 0, section: 0)) as! ItemCell
        
        cell.configCellWithItem(item: ToDoItem(title: "First", itemDescription: nil, timestamp: 1456150025, location: Location(name: "Home")))
        XCTAssertEqual(cell.titleLabel.text, "First")
        XCTAssertEqual(cell.locationLabel.text, "Home")
        XCTAssertEqual(cell.dateLabel.text, "02/22/2016")
    }
    
    func testTitle_ForCheckedTesks_IsStrokeThorugh() {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemCell.self), for: IndexPath(row: 0, section: 0)) as! ItemCell
        
        let todoItem = ToDoItem(title: "First", itemDescription: nil, timestamp: 1456150025, location: Location(name: "Home"))
        cell.configCellWithItem(item: todoItem, checked: true)
        
        let attributedString =  NSAttributedString(string: "First", attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue ])
        
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
        XCTAssertNil(cell.locationLabel.text)
        XCTAssertNil(cell.dateLabel.text)
    }
}

extension ItemCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
    }
}
