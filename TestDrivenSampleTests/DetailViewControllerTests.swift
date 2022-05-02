//
//  DetailViewControllertests.swift
//  TestDrivenSampleTests
//
//  Created by Arrr Park on 2022/05/02.
//

import XCTest
import CoreLocation
@testable import TestDrivenSample

class DetailViewControllerTests: XCTestCase {
    var sut: DetailViewController!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as! DetailViewController
        
        _ = sut.view
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func test_HasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
    }
    
    func test_HasMapView() {
        XCTAssertNotNil(sut.mapView)
    }
    
    func testSettingItemInfo_SetsTextsToLabels() {
        let coordinate = CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735)
        
        let itemManager = ItemManager()
        let item =  ToDoItem(title: "The Title", itemDescription: "The description", timestamp: 1456150025, location: Location(name: "Home", coordinate: coordinate))
        itemManager.addItem(item: item)
        
        sut.itemInfo = (itemManager, 0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(sut.titleLabel.text, item.title)
        XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
        XCTAssertEqual(sut.locationLabel.text, item.location?.name)
        XCTAssertEqual(sut.descriptionLabel.text, item.itemDescription)
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, coordinate.latitude, accuracy: 0.001)
    }
    
    func testCheckItem_ChecksItemInItemManater() {
        let itemManager = ItemManager()
        itemManager.addItem(item: ToDoItem(title: "The title"))
        sut.itemInfo = (itemManager, 0)
        sut.checkItem()
        
        XCTAssertEqual(itemManager.toDoCount, 0)
        XCTAssertEqual(itemManager.doneCount, 1)
    }
}
