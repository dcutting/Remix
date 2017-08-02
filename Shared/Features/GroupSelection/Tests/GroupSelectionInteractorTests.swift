//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest
import Entity
import Service

class GroupSelectionInteractorTests: XCTestCase {

    var mockGroupService: MockGroupService!
    var subjectUnderTest: GroupSelectionInteractor!

    override func setUp() {
        mockGroupService = MockGroupService()
        subjectUnderTest = GroupSelectionInteractor(groupService: mockGroupService)
    }

    func test_findSelectionType_groupDoesNotExist_returnsError() {
        subjectUnderTest.findSelectionType(for: "1") { result in
            switch result {
            case .error:
                XCTAssertTrue(true)
            default:
                XCTFail()
            }
        }
    }

    func test_findSelectionType_groupWithoutChildren_returnsLeafGroup() {
        mockGroupService.groups = [
            makeGroup(groupID: "1", children: [])
        ]
        subjectUnderTest.findSelectionType(for: "1") { result in
            switch result {
            case let .success(actual):
                XCTAssertEqual(GroupSelectionInteractor.SelectionType.leafGroup, actual)
            default:
                XCTFail()
            }
        }
    }

    func test_findSelectionType_groupWithChildren_returnsParentGroup() {
        mockGroupService.groups = [
            makeGroup(groupID: "1", children: ["2"])
        ]
        subjectUnderTest.findSelectionType(for: "1") { result in
            switch result {
            case let .success(actual):
                XCTAssertEqual(GroupSelectionInteractor.SelectionType.parentGroup, actual)
            default:
                XCTFail()
            }
        }
    }

    func test_fetchGroups_nilParentGroupID_returnsRootGroups() {
        let mockGroups = [
            makeGroup(groupID: "1", parent: nil),
            makeGroup(groupID: "2", parent: "1"),
            makeGroup(groupID: "3", parent: nil)
        ]
        mockGroupService.groups = mockGroups

        subjectUnderTest.fetchGroups(parentGroupID: nil) { result in

            switch result {
            case let .success(actual):
                let expected = [
                    mockGroups[0],
                    mockGroups[2]
                ]
                XCTAssertEqual(expected, actual)
            default:
                XCTFail()
            }
        }
    }
}
