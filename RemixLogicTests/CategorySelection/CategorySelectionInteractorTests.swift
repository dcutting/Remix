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

    func test_fetchCategories_nilParentCategoryID_returnsRootCategories() {
        let mockCategories = [
            makeCategory(categoryID: "1", parent: nil),
            makeCategory(categoryID: "2", parent: "1"),
            makeCategory(categoryID: "3", parent: nil)
        ]
        mockCategoryService.categories = mockCategories

        subjectUnderTest.fetchCategories(parentCategoryID: nil) { actual in
            let expected = [
                mockCategories[0],
                mockCategories[2]
            ]
            XCTAssertEqual(expected, actual)
        }
    }
}
