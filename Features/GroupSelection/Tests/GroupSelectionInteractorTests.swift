//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest
import Entity
import EntityTests
import Services

class GroupSelectionInteractorTests: XCTestCase {

    var mockGroupService: MockGroupService!
    var subjectUnderTest: GroupSelectionInteractor!

    override func setUp() {
        mockGroupService = MockGroupService()
        subjectUnderTest = GroupSelectionInteractor(groupService: mockGroupService)
    }

    func test_findSelectionType_groupDoesNotExist_returnsNotFound() {
        subjectUnderTest.findSelectionType(for: "1") { actual in
            XCTAssertEqual(GroupSelectionInteractor.SelectionType.notFound, actual)
        }
    }

    func test_findSelectionType_groupWithoutChildren_returnsLeafGroup() {
        mockGroupService.groups = [
            makeGroup(groupID: "1", children: [])
        ]
        subjectUnderTest.findSelectionType(for: "1") { actual in
            XCTAssertEqual(GroupSelectionInteractor.SelectionType.leafGroup, actual)
        }
    }

    func test_findSelectionType_groupWithChildren_returnsParentGroup() {
        mockGroupService.groups = [
            makeGroup(groupID: "1", children: ["2"])
        ]
        subjectUnderTest.findSelectionType(for: "1") { actual in
            XCTAssertEqual(GroupSelectionInteractor.SelectionType.parentGroup, actual)
        }
    }

    func test_fetchGroups_nilParentGroupID_returnsRootGroups() {
        let mockGroups = [
            makeGroup(groupID: "1", parent: nil),
            makeGroup(groupID: "2", parent: "1"),
            makeGroup(groupID: "3", parent: nil)
        ]
        mockGroupService.groups = mockGroups

        subjectUnderTest.fetchGroups(parentGroupID: nil) { actual in
            let expected = [
                mockGroups[0],
                mockGroups[2]
            ]
            XCTAssertEqual(expected, actual)
        }
    }
}
