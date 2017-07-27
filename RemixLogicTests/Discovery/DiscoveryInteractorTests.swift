//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest
import Core

class DicoveryInteractorTests: XCTestCase {

    var mockAdvertService: MockAdvertService!
    var subjectUnderTest: DiscoveryInteractor!

    override func setUp() {
        mockAdvertService = MockAdvertService()
        subjectUnderTest = DiscoveryInteractor(advertService: mockAdvertService)
    }

    func test_fetchDetail_advertNotFound_returnsNil() {

        mockAdvertService.adverts = [Advert]()

        subjectUnderTest.fetchDetail(for: "1") { actual in

            XCTAssertNil(actual)
        }
    }

    func test_fetchDetail_advertFound_returnsAdvert() {

        let mockAdverts = [
            makeAdvert(advertID: "1", title: "hello", categoryID: "9")
        ]
        mockAdvertService.adverts = mockAdverts

        subjectUnderTest.fetchDetail(for: "1") { actual in

            let expected = mockAdverts[0]
            XCTAssertEqual(expected, actual)
        }
    }
}
