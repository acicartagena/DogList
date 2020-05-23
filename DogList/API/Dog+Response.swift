//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

enum ProcessingError: Error {
    typealias ImageId = String
    case data(ImageId)
    case lifeSpan(String)
}

extension Dog {
    // assume error handling of wrong response information for lists returns a nil for that instance. compact map can be used to remove invalid information
    init(response: DogListImageResponse) throws {
        guard let breed = response.breeds.first,
            let imageURL = URL(string: response.url)
        else { throw ProcessingError.data(response.id) }

        name = breed.name
        self.imageURL = imageURL
        temperament = breed.temperament

        // assume if lifeSpan string can't be converted, data's valid but lifespan is nil
        lifeSpan = try LifeSpanYear(response: breed.lifeSpan)
    }
}

extension Dog.LifeSpanYear {
    // assume valid strings for lifespan is either:
    // "x - y years" or "z years". returns nil if it's not the case
    init(response: String) throws {
        let processedLowerCase = response.lowercased()
        guard processedLowerCase.hasSuffix("years") else {
            throw ProcessingError.lifeSpan(response)
        }
        let processedComponents = processedLowerCase.components(separatedBy: " ")

        if let dashIndex = processedComponents.firstIndex(of: "-"),
            dashIndex + 1 < processedComponents.count {
            // handles "x - y years" string, assume first and item after "-" in processed components is the min and max
            let minString = processedComponents.first ?? ""
            let maxIndex = dashIndex + 1
            let maxString = processedComponents[maxIndex]

            guard let min = Int(minString), let max = Int(maxString) else {
                throw ProcessingError.lifeSpan(response)
            }
            self = .range(min, max)
        } else {
            // handles "x years" string, assume first item is the number of years
            let yearsString = processedComponents.first ?? ""
            guard let years = Int(yearsString) else {
                throw ProcessingError.lifeSpan(response)
            }
            self = .constant(years)
        }
    }
}
