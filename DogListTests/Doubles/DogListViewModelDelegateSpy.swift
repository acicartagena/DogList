//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
@testable import DogList

class DogListViewModelDelegateSpy: DogListViewModelDelegate {
    var calls: [String] = []

    func reloadData() {
        calls.append("reloadData()")
    }

    func showError(message: String) {
        calls.append("showError(message: \(message))")
    }
}
