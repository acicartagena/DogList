//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
import BrightFutures
@testable import DogList

class DogListActionsStub: DogListActions {
    var fetchImagesResult: Result<[Dog], DogListError>!

    func fetchImages() -> Future<[Dog], DogListError> {
        return Future(result: fetchImagesResult)
    }
}
