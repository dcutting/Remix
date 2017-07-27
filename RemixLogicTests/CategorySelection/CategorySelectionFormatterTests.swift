//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest

class CategorySelectionFormatterTests: XCTestCase {

    func testFormatter() {

        let formatter = CategorySelectionFormatter()
        let categories = [
            Category(categoryID: "1", parent: nil, children: ["1"], title: "Cars"),
            Category(categoryID: "2", parent: "1", children: [], title: "Racing cars"),
            Category(categoryID: "3", parent: nil, children: [], title: "Bicycles"),
        ]

        let actual = formatter.prepare(categories: categories)

        XCTAssertEqual("Select category", actual.title)

        XCTAssertEqual(3, actual.items.count)

        XCTAssertEqual("1", actual.items[0].categoryID)
        XCTAssertEqual("Cars", actual.items[0].title)
        XCTAssertTrue(actual.items[0].hasChildren)

        XCTAssertEqual("2", actual.items[1].categoryID)
        XCTAssertEqual("Racing cars", actual.items[1].title)
        XCTAssertFalse(actual.items[1].hasChildren)

        XCTAssertEqual("3", actual.items[2].categoryID)
        XCTAssertEqual("Bicycles", actual.items[2].title)
        XCTAssertFalse(actual.items[2].hasChildren)
    }
}
