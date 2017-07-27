//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest
@testable import Core

class DiscoveryDetailFormatterTests: XCTestCase {

    var subjectUnderTest: DiscoveryDetailFormatter!

    override func setUp() {
        subjectUnderTest = DiscoveryDetailFormatter()
    }

    func test_prepare_returnsTitle() {
        let advert = makeAdvert(advertID: "1", title: "hello world")

        let actual = subjectUnderTest.prepare(advert: advert)

        XCTAssertEqual("hello world", actual.title)
    }
}
