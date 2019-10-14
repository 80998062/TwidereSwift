//
//  AuthorizeTests.swift
//  AuthorizeTests
//
//  Created by 沈烨坷 on 2018/9/28.
//  Copyright © 2018 Sinyuk. All rights reserved.
//

import XCTest
@testable import Authorize

class AuthorizeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRandomString() {
        let result = randomString(length: 10)
        print("RandomString: \(String(describing: result))")
        XCTAssert(result.count == 10)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
