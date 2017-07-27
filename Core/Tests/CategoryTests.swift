//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest

class CategoryTests: XCTestCase {

    func test_equal_same_returnsTrue() {

        let categoryA = makeCategory(categoryID: "1", parent: "6", children: ["4", "6"], title: "hello world")
        let categoryB = makeCategory(categoryID: "1", parent: "6", children: ["4", "6"], title: "hello world")

        XCTAssertEqual(categoryA, categoryB)
    }

    func test_equal_differentID_returnsFalse() {

        let categoryA = makeCategory(categoryID: "1", parent: "6", children: ["4", "6"], title: "hello world")
        let categoryB = makeCategory(categoryID: "2", parent: "6", children: ["4", "6"], title: "hello world")

        XCTAssertNotEqual(categoryA, categoryB)
    }

    func test_equal_differentParent_returnsFalse() {

        let categoryA = makeCategory(categoryID: "1", parent: "3", children: ["4", "6"], title: "hello world")
        let categoryB = makeCategory(categoryID: "1", parent: "6", children: ["4", "6"], title: "hello world")

        XCTAssertNotEqual(categoryA, categoryB)
    }

    func test_equal_differentChildren_returnsFalse() {

        let categoryA = makeCategory(categoryID: "1", parent: "6", children: ["4", "6"], title: "hello world")
        let categoryB = makeCategory(categoryID: "1", parent: "6", children: ["4"], title: "hello world")

        XCTAssertNotEqual(categoryA, categoryB)
    }

    func test_equal_differentTitle_returnsFalse() {

        let categoryA = makeCategory(categoryID: "1", parent: "6", children: ["4", "6"], title: "hello world")
        let categoryB = makeCategory(categoryID: "1", parent: "6", children: ["4", "6"], title: "goddbye world")

        XCTAssertNotEqual(categoryA, categoryB)
    }
}
