//  Copyright © 2020 ACartagena. All rights reserved.

import BrightFutures
@testable import DogList
import XCTest

class DogListViewModelTests: XCTestCase {
    var actions: DogListActionsStub!
    var delegate: DogListViewModelDelegateSpy!
    var subject: DogListViewModel!

    override func setUpWithError() throws {
        actions = DogListActionsStub()
        delegate = DogListViewModelDelegateSpy()
        subject = DogListViewModel(actions: actions, threadingModel: { ImmediateExecutionContext })
        subject.delegate = delegate
    }

    func testFetchSuccess() {
        actions.fetchImagesResult = .success([DogBuilder().build()])

        subject.start()

        XCTAssertEqual(delegate.calls, ["reloadData()"])
        XCTAssertEqual(subject.items, [DogBuilder().build()])
    }

    func testFetchError() {
        actions.fetchImagesResult = .failure(.noData)

        subject.start()

        XCTAssertEqual(delegate.calls, ["showError(message: No data returned)"])
        XCTAssertEqual(subject.items, [])
    }

    func testSortAscending() {
        let dog1 = DogBuilder().with(lifeSpan: .range(12, 15)).build()
        let dog2 = DogBuilder().with(lifeSpan: .constant(10)).build()
        let dog3 = DogBuilder().with(lifeSpan: .range(9, 11)).build()
        actions.fetchImagesResult = .success([dog1, dog2, dog3])

        subject.start()
        subject.sort(by: .ascending)

        XCTAssertEqual(delegate.calls, ["reloadData()", "reloadData()"])
        XCTAssertEqual(subject.items, [dog2, dog3, dog1])
    }

    func testSortDescending() {
        let dog1 = DogBuilder().with(lifeSpan: .range(12, 15)).build()
        let dog2 = DogBuilder().with(lifeSpan: .constant(10)).build()
        let dog3 = DogBuilder().with(lifeSpan: .range(9, 11)).build()
        actions.fetchImagesResult = .success([dog1, dog2, dog3])

        subject.start()
        subject.sort(by: .descending)

        XCTAssertEqual(delegate.calls, ["reloadData()", "reloadData()"])
        XCTAssertEqual(subject.items, [dog1, dog3, dog2])
    }
}
