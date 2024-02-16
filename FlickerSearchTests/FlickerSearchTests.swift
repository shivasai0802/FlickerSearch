//
//  FlickerSearchTests.swift
//  FlickerSearchTests
//
//  Created by shiva on 2/15/24.
//

import XCTest
@testable import FlickerSearch

class FlickerSearchTests: XCTestCase {
    func testFlickerSearchBarView_Initialization() {
        let view = FlickerSearchBarView(searchText: "")
        XCTAssertNotNil(view)
    }
    
    func testFlickerSearchBarView_SearchTextChange() {
        let view = FlickerSearchBarView(searchText: "porcupine")
        
        // Verify that the searchText has changed
        XCTAssertEqual(view.searchText, "porcupine")
    }
}

class MockFlickerService: FlickerService {
    var shouldSucceed: Bool = true
    var mockFlickerData: FlickerData?
    
    override func fetchFlickerData(searchText: String, completion: @escaping (Result<FlickerData, Error>) -> Void) {
        if shouldSucceed {
            if let mockData = mockFlickerData {
                completion(.success(mockData))
            } else {
                let defaultMockData = FlickerData(title: "bald eagle", link: "https:www.flickr.com/photos/198268140@N06/53531609173/",
                                                  description: "",
                                                  modified: "",
                                                  generator: "",
                                                  items: [Item(title: "bald eagle",
                                                               link: "https:www.flickr.com/photos/198268140@N06/53531609173/",
                                                               media:  Media(m: "https:live.staticflickr.com/65535/53531609173_ef53385ebf_m.jpg"),
                                                               date_taken: "2024-02-14T17:06:09-08:00",
                                                               description: "",
                                                               published: "2024-02-15T21:04:31Z",
                                                               author: "nobody@flickr.com (\"Michaelst2007\")",
                                                               author_id: "198268140@N06",
                                                               tags: "eagle bird birds birding")])
                completion(.success(defaultMockData))
            }
        } else {
            let error = NSError(domain: "MockError", code: 00, userInfo: nil)
            completion(.failure(error))
        }
    }
}

class FlickerListViewModelTests: XCTestCase {
    var viewModel: FlickerListViewModel!
    var mockFlickerService: MockFlickerService!
    
    override func setUp() {
        super.setUp()
        mockFlickerService = MockFlickerService()
        viewModel = FlickerListViewModel()
        viewModel.flickerService = mockFlickerService
    }
    
    func testFetchFlickerData_Success() {
        mockFlickerService.shouldSucceed = true
        let expectation = XCTestExpectation(description: "Fetch Flicker Data")
        viewModel.fetchFlickerData(searchText: "eagle")
        XCTWaiter().wait(for: [expectation], timeout: 2)
        expectation.fulfill()
        XCTAssertNotNil(viewModel.flickerData)
    }
    
    func testFetchFlickerData_Failure() {
        mockFlickerService.shouldSucceed = false
        let expectation = XCTestExpectation(description: "Fetch Flicker Data")
        
        viewModel.fetchFlickerData(searchText: "")
        expectation.fulfill()
        wait(for: [expectation], timeout: 1.0)
        
        XCTAssertNil(viewModel.flickerData)
    }
}
