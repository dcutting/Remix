//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest
import Entity
import Service

class DicoveryInteractorTests: XCTestCase {

    var mockAdvertService: MockAdvertService!
    var subjectUnderTest: DiscoveryInteractor!

    override func setUp() {
        mockAdvertService = MockAdvertService()
        subjectUnderTest = DiscoveryInteractor(advertService: mockAdvertService)
    }

    func test_fetchDetail_advertNotFound_returnsNil() {

        mockAdvertService.adverts = [Advert]()

        subjectUnderTest.fetchDetail(for: "1") { result in

            guard case .error = result else {
                XCTFail()
                return
            }
        }
    }

    func test_fetchDetail_advertFound_returnsAdvert() {

        let mockAdverts = [
            makeAdvert(advertID: "1", title: "hello", groupID: "9")
        ]
        mockAdvertService.adverts = mockAdverts

        subjectUnderTest.fetchDetail(for: "1") { result in

            switch result {
            case let .success(actual):
                let expected = mockAdverts[0]
                XCTAssertEqual(expected, actual)
            default:
                XCTFail()
            }
        }
    }
}
