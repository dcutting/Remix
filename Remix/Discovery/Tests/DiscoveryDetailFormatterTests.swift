//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest
import Entity

class AdvertDetailFormatterTests: XCTestCase {

    var subjectUnderTest: AdvertDetailFormatter!

    override func setUp() {
        subjectUnderTest = AdvertDetailFormatter()
    }

    func test_prepare_returnsTitle() {
        let advert = makeAdvert(advertID: "1", title: "hello world")

        let actual = subjectUnderTest.prepare(advert: advert)

        XCTAssertEqual("hello world", actual.title)
    }
}
