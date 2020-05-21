//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

enum DogListError: Error {
    case networking(Error)
    case decoding(Error)
    case invalidURL(String)
    case invalidData(ProcessingError)
    case noData
    case other(Error)

    var displayError: String {
        switch self {
        case .networking(let networkingError):
            print("networking: \(networkingError)")
            return networkingError.localizedDescription
        case .decoding(let decodingError):
            print("decoding: \(decodingError)")
            return NSLocalizedString("Data issue", comment: "")
        case .invalidURL(let url):
            print("invalid url: \(url)")
            return NSLocalizedString("Something went wrong", comment: "")
        case .invalidData(let error):
            print("invalid data: \(error)")
            return NSLocalizedString("Data issue", comment: "")
        case .other(let error):
            print("other: \(error)")
            return NSLocalizedString("Something went wrong", comment: "")
        case .noData:
            print("no data")
            return NSLocalizedString("No data returned", comment: "")

        }
    }
}
