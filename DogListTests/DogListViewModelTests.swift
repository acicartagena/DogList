//  Copyright © 2020 ACartagena. All rights reserved.

import XCTest
import BrightFutures
@testable import DogList

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

    func testFetchImageSuccess() {
        actions.fetchImagesResult = .success([DogBuilder().build()])

        subject.start()

        XCTAssertEqual(delegate.calls, ["reloadData()"])
        XCTAssertEqual(subject.items, [DogBuilder().build()])
    }

}
