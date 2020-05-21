//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

struct Dog {
    enum LifeSpanYear {
        typealias Min = Int
        typealias Max = Int

        case range(Min, Max)
        case constant(Int)

        var average: Int {
            switch self {
            case let .range(min, max): return (min + max) / 2
            case let .constant(value): return value
            }
        }
    }

    let name: String
    let lifeSpan: LifeSpanYear?
    let imageURL: URL
    let temperament: String?
}

extension Dog.LifeSpanYear: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.average == rhs.average
    }
}

extension Dog.LifeSpanYear: Comparable {
    static func < (lhs: Self, rhs: Self) -> Bool {
        return lhs.average < rhs.average
    }

    static func <= (lhs: Self, rhs: Self) -> Bool {
        return lhs.average <= rhs.average
    }

    static func >= (lhs: Self, rhs: Self) -> Bool {
        return lhs.average >= rhs.average
    }

    static func > (lhs: Self, rhs: Self) -> Bool {
        return lhs.average > rhs.average
    }
}
