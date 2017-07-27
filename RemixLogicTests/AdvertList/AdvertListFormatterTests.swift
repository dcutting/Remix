//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest

class AdvertListFormatterTests: XCTestCase {

    var subjectUnderTest: AdvertListFormatter!

    override func setUp() {
        subjectUnderTest = AdvertListFormatter()
    }

    func test_prepare_findsAllCategories_returnsAdvertAndCategoryNames() {

        let adverts = [
            makeAdvert(advertID: "1", title: "First", categoryID: "5"),
            makeAdvert(advertID: "2", title: "Second", categoryID: "9"),
            makeAdvert(advertID: "3", title: "Third", categoryID: "9")
        ]
        let categories = [
            makeCategory(categoryID: "5", title: "Pets"),
            makeCategory(categoryID: "9", title: "Vehicles")
        ]

        let actual = subjectUnderTest.prepare(adverts: adverts, categories: categories)

        XCTAssertEqual(3, actual.items.count)

        XCTAssertEqual("1", actual.items[0].advertID)
        XCTAssertEqual("First", actual.items[0].title)
        XCTAssertEqual("Pets", actual.items[0].category)

        XCTAssertEqual("2", actual.items[1].advertID)
        XCTAssertEqual("Second", actual.items[1].title)
        XCTAssertEqual("Vehicles", actual.items[1].category)

        XCTAssertEqual("3", actual.items[2].advertID)
        XCTAssertEqual("Third", actual.items[2].title)
        XCTAssertEqual("Vehicles", actual.items[2].category)
    }

    func test_prepare_missingCategory_returnsEmptyStringAsCategoryName() {

        let adverts = [
            makeAdvert(advertID: "1", title: "First", categoryID: "5")
        ]
        let categories = [Category]()

        let actual = subjectUnderTest.prepare(adverts: adverts, categories: categories)

        XCTAssertEqual("1", actual.items[0].advertID)
        XCTAssertEqual("First", actual.items[0].title)
        XCTAssertEqual("", actual.items[0].category)
    }
}
