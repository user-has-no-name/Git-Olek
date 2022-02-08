//
//  GlobalExtensionsTests.swift
//  GitOlekTests
//
//  Created by Oleksandr Zavazhenko on 08/02/2022.
//

import XCTest
@testable import GitOlek

class GlobalExtensionsTests: XCTestCase {

  /// Testing verify method of a String extension
  /// It should return false if a query is empty,
  /// otherwise it should be true
  func testVerifyingQuery() {

    let emptyQuerry = "" // Empty string
    let correctQuery = "Alamofire" // Not empty query

    XCTAssertFalse(emptyQuerry.verify())
    XCTAssertTrue(correctQuery.verify())
  }

  /// Testing converDate method of a String extension
  /// It should convert date received in a format ISO8601 to the date
  /// formatted in "dd-MM-yyyy"
  func testConvertingDateFromISO8601() {

    let correctDate = "2014-02-04T14:38:36-08:00"
    let emptyDate = ""
    let incorrectFormat = "03-02-2013"

    XCTAssertEqual(correctDate.convertDate(), "04-02-2014")
    XCTAssertEqual(emptyDate.convertDate(), "")
    XCTAssertEqual(incorrectFormat.convertDate(), "")

  }

  /// Testing roundedWithAbbreviations method of a Int extension
  /// It should convert a number by adding an abbreviation
  func testRoundingNumbersWithAbbreviations() {

    let hundred = 100
    let thousand = 1325
    let million = 1351325

    XCTAssertEqual(hundred.roundedWithAbbreviations, "100")
    XCTAssertEqual(thousand.roundedWithAbbreviations, "1.3K")
    XCTAssertEqual(million.roundedWithAbbreviations, "1.4M")
  }
}
