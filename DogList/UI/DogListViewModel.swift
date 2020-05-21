//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

class DogListViewModel {
    
}

extension Dog.LifeSpanYear {
    var display: String {
        switch self {
        case let .range(min, max):
            return String.localizedStringWithFormat(NSLocalizedString("%i - %i years", comment: "Life span years with range"), min, max)
        case let .constant(value):
            return String.localizedStringWithFormat(NSLocalizedString("%i years", comment: "Life span constant value"), value)
        }
    }
}
