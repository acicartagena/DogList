//  Copyright © 2020 ACartagena. All rights reserved.

import BrightFutures
import Foundation

protocol DogListActions {
    func fetchImages() -> Future<[Dog], DogListError>
}

class DogListService: DogListActions {
    enum ImageSize {
        case small
        case thumbnail

        var queryItem: String {
            switch self {
            case .small: return "small"
            case .thumbnail: return "thumbnail"
            }
        }
    }

    private let defaultLimit = 50
    private let defaultSize: ImageSize = .thumbnail

    private let networking = Networking()

    func fetchImages() -> Future<[Dog], DogListError> {
        return fetchImages(limit: defaultLimit, size: defaultSize)
    }

    func fetchImages(limit: Int, size: ImageSize) -> Future<[Dog], DogListError> {
        let urlString = "https://api.thedogapi.com/v1/images/search"
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [URLQueryItem(name: "limit", value: "\(limit)"),
                                     URLQueryItem(name: "size", value: size.queryItem)]

        guard let url = urlComponents?.url else {
            return Future(error: .invalidURL(urlString))
        }

        let tagListResponse: Future<[DogListImageResponse], DogListError> = networking.request(url: url)
        return tagListResponse.map { imageResponses in
            imageResponses.compactMap { try? Dog(response: $0) }
        }
    }
}
