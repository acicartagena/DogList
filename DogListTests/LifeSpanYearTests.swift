//  Copyright © 2020 ACartagena. All rights reserved.

import XCTest
@testable import DogList

class LifeSpanYearTests: XCTestCase {

    func testValidConstantYear() {
        let response = "10 years"
        let subject = try! Dog.LifeSpanYear(response: response)

        XCTAssertEqual(subject, Dog.LifeSpanYear.constant(10))
    }

    func testValidRangeYear() {
        let response = "10 - 15 years"
        let subject = try! Dog.LifeSpanYear(response: response)

        XCTAssertEqual(subject, Dog.LifeSpanYear.range(10, 15))
    }

    func testMultipleYearsNoDash() {
        let response = "10 15 years"
        let subject = try! Dog.LifeSpanYear(response: response)

        XCTAssertEqual(subject, Dog.LifeSpanYear.constant(10))
    }

    func testInvalidYear() {
        let response = "yea"
        XCTAssertThrowsError(try Dog.LifeSpanYear(response: response))
    }

    func testMultipleDashes() {
        let response = "10 - - 15 years"
        XCTAssertThrowsError(try Dog.LifeSpanYear(response: response))
    }

    func testUnexpectedSpacingDifference() {
        let response = "10-15 years"
        XCTAssertThrowsError(try Dog.LifeSpanYear(response: response))
    }

}
