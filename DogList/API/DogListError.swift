//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

enum DogListError: Error {
    case networking(Error)
    case decoding(Error)
    case invalidURL(String)
    case invalidData(ProcessingError)
    case noData
    case other(Error)
}
