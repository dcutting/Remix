//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest
@testable import Core

class AdvertListInteractorTests: XCTestCase {

    var mockAdvertService: MockAdvertService!
    var mockGroupService: MockGroupService!
    var subjectUnderTest: AdvertListInteractor!

    override func setUp() {
        mockAdvertService = MockAdvertService()
        mockGroupService = MockGroupService()
        subjectUnderTest = AdvertListInteractor(advertService: mockAdvertService, groupService: mockGroupService)
    }

    func test_update_nilGroup_returnsAllAdvertsAndGroups() {

        let mockAdverts = [
            makeAdvert(advertID: "1", groupID: "1"),
            makeAdvert(advertID: "2", groupID: "1"),
            makeAdvert(advertID: "3", groupID: "2"),
            makeAdvert(advertID: "4", groupID: "3")
        ]
        let mockGroups = [
            makeGroup(groupID: "1"),
            makeGroup(groupID: "2"),
            makeGroup(groupID: "3")
        ]

        mockAdvertService.adverts = mockAdverts
        mockGroupService.groups = mockGroups

        subjectUnderTest.update(for: nil) { (actualAdverts, actualGroups) in

            let expectedAdverts = mockAdverts
            XCTAssertEqual(expectedAdverts, actualAdverts)

            let expectedGroups = mockGroups
            XCTAssertEqual(expectedGroups, actualGroups)
        }
    }

    func test_update_setGroup_returnsAllGroupsAndAdvertsInThatGroup() {

        let mockAdverts = [
            makeAdvert(advertID: "1", groupID: "1"),
            makeAdvert(advertID: "2", groupID: "1"),
            makeAdvert(advertID: "3", groupID: "2"),
            makeAdvert(advertID: "4", groupID: "3")
        ]
        let mockGroups = [
            makeGroup(groupID: "1"),
            makeGroup(groupID: "2"),
            makeGroup(groupID: "3")
        ]

        mockAdvertService.adverts = mockAdverts
        mockGroupService.groups = mockGroups

        subjectUnderTest.update(for: "1") { (actualAdverts, actualGroups) in

            let expectedAdverts = [
                mockAdverts[0], mockAdverts[1]
            ]
            XCTAssertEqual(expectedAdverts, actualAdverts)

            let expectedGroups = mockGroups
            XCTAssertEqual(expectedGroups, actualGroups)
        }
    }
}
