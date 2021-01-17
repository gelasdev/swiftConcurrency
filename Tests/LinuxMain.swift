import XCTest

import ConcurrencyTests

var tests = [XCTestCaseEntry]()
tests += ConcurrencyTests.allTests()
XCTMain(tests)
