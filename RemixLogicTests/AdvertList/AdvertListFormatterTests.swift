//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest
import Entity

class AdvertListFormatterTests: XCTestCase {

    var subjectUnderTest: AdvertListFormatter!

    override func setUp() {
        subjectUnderTest = AdvertListFormatter()
    }

    func test_prepare_findsAllGroups_returnsAdvertAndGroupNames() {

        let adverts = [
            makeAdvert(advertID: "1", title: "First", groupID: "5"),
            makeAdvert(advertID: "2", title: "Second", groupID: "9"),
            makeAdvert(advertID: "3", title: "Third", groupID: "9")
        ]
        let groups = [
            makeGroup(groupID: "5", title: "Pets"),
            makeGroup(groupID: "9", title: "Vehicles")
        ]

        let actual = subjectUnderTest.prepare(adverts: adverts, groups: groups)

        XCTAssertEqual(3, actual.items.count)

        XCTAssertEqual("1", actual.items[0].advertID)
        XCTAssertEqual("First", actual.items[0].title)
        XCTAssertEqual("Pets", actual.items[0].group)

        XCTAssertEqual("2", actual.items[1].advertID)
        XCTAssertEqual("Second", actual.items[1].title)
        XCTAssertEqual("Vehicles", actual.items[1].group)

        XCTAssertEqual("3", actual.items[2].advertID)
        XCTAssertEqual("Third", actual.items[2].title)
        XCTAssertEqual("Vehicles", actual.items[2].group)
    }

    func test_prepare_missingGroup_returnsEmptyStringAsGroupName() {

        let adverts = [
            makeAdvert(advertID: "1", title: "First", groupID: "5")
        ]
        let groups = [Group]()

        let actual = subjectUnderTest.prepare(adverts: adverts, groups: groups)

        XCTAssertEqual("1", actual.items[0].advertID)
        XCTAssertEqual("First", actual.items[0].title)
        XCTAssertEqual("", actual.items[0].group)
    }
}
