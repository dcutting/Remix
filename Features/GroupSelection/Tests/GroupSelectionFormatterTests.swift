//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest
import Entity

class GroupSelectionFormatterTests: XCTestCase {

    func test_prepare() {

        let formatter = GroupSelectionFormatter()
        let groups = [
            Group(groupID: "1", parent: nil, children: ["1"], title: "Cars"),
            Group(groupID: "2", parent: "1", children: [], title: "Racing cars"),
            Group(groupID: "3", parent: nil, children: [], title: "Bicycles"),
        ]

        let actual = formatter.prepare(groups: groups)

        XCTAssertEqual("Select group", actual.title)

        XCTAssertEqual(3, actual.items.count)

        XCTAssertEqual("1", actual.items[0].groupID)
        XCTAssertEqual("Cars", actual.items[0].title)
        XCTAssertTrue(actual.items[0].hasChildren)

        XCTAssertEqual("2", actual.items[1].groupID)
        XCTAssertEqual("Racing cars", actual.items[1].title)
        XCTAssertFalse(actual.items[1].hasChildren)

        XCTAssertEqual("3", actual.items[2].groupID)
        XCTAssertEqual("Bicycles", actual.items[2].title)
        XCTAssertFalse(actual.items[2].hasChildren)
    }
}
