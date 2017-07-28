//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest
import Entity

class AdvertTests: XCTestCase {

    func test_equal_same_returnsTrue() {

        let advertA = makeAdvert(advertID: "1", title: "hello world", groupID: "9")
        let advertB = makeAdvert(advertID: "1", title: "hello world", groupID: "9")

        XCTAssertEqual(advertA, advertB)
    }

    func test_equal_differentID_returnsFalse() {

        let advertA = makeAdvert(advertID: "1", title: "hello world", groupID: "9")
        let advertB = makeAdvert(advertID: "2", title: "hello world", groupID: "9")

        XCTAssertNotEqual(advertA, advertB)
    }

    func test_equal_differentTitle_returnsFalse() {

        let advertA = makeAdvert(advertID: "1", title: "hello world", groupID: "9")
        let advertB = makeAdvert(advertID: "1", title: "goodbye world", groupID: "9")

        XCTAssertNotEqual(advertA, advertB)
    }

    func test_equal_differentGroupID_returnsFalse() {

        let advertA = makeAdvert(advertID: "1", title: "hello world", groupID: "9")
        let advertB = makeAdvert(advertID: "1", title: "hello world", groupID: "7")

        XCTAssertNotEqual(advertA, advertB)
    }
}
