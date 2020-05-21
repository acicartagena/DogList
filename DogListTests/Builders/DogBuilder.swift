//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
@testable import DogList

//struct Dog {
//    enum LifeSpanYear {
//        typealias Min = Int
//        typealias Max = Int
//
//        case range(Min, Max)
//        case constant(Int)
//
//        var average: Int {
//            switch self {
//            case let .range(min, max): return (min + max) / 2
//            case let .constant(value): return value
//            }
//        }
//    }
//
//    let name: String
//    let lifeSpan: LifeSpanYear?
//    let imageURL: URL
//    let temperament: String?
//}

class DogBuilder {
    private var name = "Beagle"
    private var lifeSpan: Dog.LifeSpanYear = .range(13, 16)
    private var imageURL = URL(string: "https://cdn2.thedogapi.com/images/Syd4xxqEm_1280.jpg")!
    private var temperament = "Amiable, Even Tempered, Excitable, Determined, Gentle, Intelligent"

    func with(name: String) -> DogBuilder {
        self.name = name
        return self
    }

    func with(lifeSpan: Dog.LifeSpanYear) -> DogBuilder {
        self.lifeSpan = lifeSpan
        return self
    }

    func with(lifeSpanText: String) -> DogBuilder {
        self.lifeSpan = try! Dog.LifeSpanYear(response: lifeSpanText)
        return self
    }

    func with(imageURL: URL) -> DogBuilder {
        self.imageURL = imageURL
        return self
    }

    func with(temperament: String) -> DogBuilder {
        self.temperament = temperament
        return self
    }

    func build() -> Dog {
        return Dog(name: name, lifeSpan: lifeSpan, imageURL: imageURL, temperament: temperament)
    }

}
