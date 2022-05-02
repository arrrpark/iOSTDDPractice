//
//  Networktest.swift
//  TestDrivenSampleTests
//
//  Created by Arrr Park on 2022/04/26.
//

import XCTest
@testable import TestDrivenSample

class NetworkTests: XCTestCase {
    var sut: URLSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testValidApiCallGetsHTTPStatusCode200() throws {
        let urlString =
        "https://www.randomnumberapi.com/api/v1.0/random?min=0&max=100&count=1"
        
        let url = URL(string: urlString)!
        // 1
        let promise = expectation(description: "Status code: 200")
        
        // when
        let dataTask = sut.dataTask(with: url) { _, response, error in
            // then
            if let error = error {
              XCTFail("Error: \(error.localizedDescription)")
              return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
              if statusCode == 200 {
                // 2
                promise.fulfill()
              } else {
                XCTFail("Status code: \(statusCode)")
              }
            }
          }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
    }
    
    func testApiCallCompletes() throws {
        // given
        let urlString = "https://www.randomnumberapi.com/test"
        let url = URL(string: urlString)!
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        // when
        let dataTask = sut.dataTask(with: url) { _, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        // then
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 404)
    }
}

