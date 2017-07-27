//  Copyright © 2017 cutting.io. All rights reserved.

import XCTest

class AdvertListInteractorTests: XCTestCase {

    var mockAdvertService: MockAdvertService!
    var mockCategoryService: MockCategoryService!
    var subjectUnderTest: AdvertListInteractor!

    override func setUp() {
        mockAdvertService = MockAdvertService()
        mockCategoryService = MockCategoryService()
        subjectUnderTest = AdvertListInteractor(advertService: mockAdvertService, categoryService: mockCategoryService)
    }

    func test_update_nilCategory_returnsAllAdvertsAndCategories() {

        let mockAdverts = [
            makeAdvert(advertID: "1", categoryID: "1"),
            makeAdvert(advertID: "2", categoryID: "1"),
            makeAdvert(advertID: "3", categoryID: "2"),
            makeAdvert(advertID: "4", categoryID: "3")
        ]
        let mockCategories = [
            makeCategory(categoryID: "1"),
            makeCategory(categoryID: "2"),
            makeCategory(categoryID: "3")
        ]

        mockAdvertService.adverts = mockAdverts
        mockCategoryService.categories = mockCategories

        subjectUnderTest.update(for: nil) { (actualAdverts, actualCategories) in

            let expectedAdverts = mockAdverts
            XCTAssertEqual(expectedAdverts, actualAdverts)

            let expectedCategories = mockCategories
            XCTAssertEqual(expectedCategories, actualCategories)
        }
    }

    func test_update_setCategory_returnsAllCategoriesAndAdvertsInThatCategory() {

        let mockAdverts = [
            makeAdvert(advertID: "1", categoryID: "1"),
            makeAdvert(advertID: "2", categoryID: "1"),
            makeAdvert(advertID: "3", categoryID: "2"),
            makeAdvert(advertID: "4", categoryID: "3")
        ]
        let mockCategories = [
            makeCategory(categoryID: "1"),
            makeCategory(categoryID: "2"),
            makeCategory(categoryID: "3")
        ]

        mockAdvertService.adverts = mockAdverts
        mockCategoryService.categories = mockCategories

        subjectUnderTest.update(for: "1") { (actualAdverts, actualCategories) in

            let expectedAdverts = [
                mockAdverts[0], mockAdverts[1]
            ]
            XCTAssertEqual(expectedAdverts, actualAdverts)

            let expectedCategories = mockCategories
            XCTAssertEqual(expectedCategories, actualCategories)
        }
    }
}
