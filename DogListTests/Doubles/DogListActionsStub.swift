//  Copyright © 2020 ACartagena. All rights reserved.

import BrightFutures
@testable import DogList
import Foundation

class DogListActionsStub: DogListActions {
    var fetchImagesResult: Result<[Dog], DogListError>!

    func fetchImages() -> Future<[Dog], DogListError> {
        return Future(result: fetchImagesResult)
    }
}
