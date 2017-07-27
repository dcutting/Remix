//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest

class CategorySelectionInteractorTests: XCTestCase {

    var mockCategoryService: MockCategoryService!
    var subjectUnderTest: CategorySelectionInteractor!

    override func setUp() {
        mockCategoryService = MockCategoryService()
        subjectUnderTest = CategorySelectionInteractor(categoryService: mockCategoryService)
    }

    func test_findSelectionType_categoryDoesNotExist_returnsNotFound() {
        subjectUnderTest.findSelectionType(for: "1") { actual in
            XCTAssertEqual(CategorySelectionInteractor.SelectionType.notFound, actual)
        }
    }

    func test_findSelectionType_categoryWithoutChildren_returnsLeafCategory() {
        mockCategoryService.categories = [
            makeCategory(categoryID: "1", children: [])
        ]
        subjectUnderTest.findSelectionType(for: "1") { actual in
            XCTAssertEqual(CategorySelectionInteractor.SelectionType.leafCategory, actual)
        }
    }

    func test_findSelectionType_categoryWithChildren_returnsParentCategory() {
        mockCategoryService.categories = [
            makeCategory(categoryID: "1", children: ["2"])
        ]
        subjectUnderTest.findSelectionType(for: "1") { actual in
            XCTAssertEqual(CategorySelectionInteractor.SelectionType.parentCategory, actual)
        }
    }

    private func makeCategory(categoryID: CategoryID, children: [CategoryID]) -> Category {
        return Category(categoryID: categoryID, parent: nil, children: children, title: "dummy title")
    }
}
