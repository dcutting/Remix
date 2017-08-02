//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest

class GroupTests: XCTestCase {

    func test_equal_same_returnsTrue() {

        let groupA = makeGroup(groupID: "1", parent: "6", children: ["4", "6"], title: "hello world", description: "first")
        let groupB = makeGroup(groupID: "1", parent: "6", children: ["4", "6"], title: "hello world", description: "first")

        XCTAssertEqual(groupA, groupB)
    }

    func test_equal_differentID_returnsFalse() {

        let groupA = makeGroup(groupID: "1", parent: "6", children: ["4", "6"], title: "hello world", description: "first")
        let groupB = makeGroup(groupID: "2", parent: "6", children: ["4", "6"], title: "hello world", description: "first")

        XCTAssertNotEqual(groupA, groupB)
    }

    func test_equal_differentParent_returnsFalse() {

        let groupA = makeGroup(groupID: "1", parent: "3", children: ["4", "6"], title: "hello world", description: "first")
        let groupB = makeGroup(groupID: "1", parent: "6", children: ["4", "6"], title: "hello world", description: "first")

        XCTAssertNotEqual(groupA, groupB)
    }

    func test_equal_differentChildren_returnsFalse() {

        let groupA = makeGroup(groupID: "1", parent: "6", children: ["4", "6"], title: "hello world", description: "first")
        let groupB = makeGroup(groupID: "1", parent: "6", children: ["4"], title: "hello world", description: "first")

        XCTAssertNotEqual(groupA, groupB)
    }

    func test_equal_differentTitle_returnsFalse() {

        let groupA = makeGroup(groupID: "1", parent: "6", children: ["4", "6"], title: "hello world", description: "first")
        let groupB = makeGroup(groupID: "1", parent: "6", children: ["4", "6"], title: "goddbye world", description: "first")

        XCTAssertNotEqual(groupA, groupB)
    }

    func test_equal_differentDescription_returnsFalse() {

        let groupA = makeGroup(groupID: "1", parent: "6", children: ["4", "6"], title: "hello world", description: "first")
        let groupB = makeGroup(groupID: "1", parent: "6", children: ["4", "6"], title: "hello world", description: "second")

        XCTAssertNotEqual(groupA, groupB)
    }
}
