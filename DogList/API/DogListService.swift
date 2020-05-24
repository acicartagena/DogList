//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

protocol DogListActions {
    func fetchImages(completion: @escaping (Result<[Dog], DogListError>) -> Void)
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

    func fetchImages(completion: @escaping (Result<[Dog], DogListError>) -> Void) {
        return fetchImages(limit: defaultLimit, size: defaultSize, completion: completion)
    }

    func fetchImages(limit: Int, size: ImageSize, completion: @escaping (Result<[Dog], DogListError>) -> Void) {
        let urlString = "https://api.thedogapi.com/v1/images/search"
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [URLQueryItem(name: "limit", value: "\(limit)"),
                                     URLQueryItem(name: "size", value: size.queryItem)]

        guard let url = urlComponents?.url else {
            completion(.failure(.invalidURL(urlString)))
            return
        }

        networking.request(url: url) { (result: Result<[DogListImageResponse], DogListError>) in
            switch result {
            case .success(let response):
                let dogs = response.compactMap { try? Dog(response: $0) }
                completion(.success(dogs))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
