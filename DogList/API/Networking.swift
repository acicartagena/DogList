//  Copyright © 2020 ACartagena. All rights reserved.

import BrightFutures
import Foundation

class Networking {
    let session = URLSession(configuration: .default)
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func request<T: Decodable>(url: URL) -> Future<T, DogListError> {
        let promise = Promise<T, DogListError>()

        session.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    promise.failure(.networking(error))
                    return
                }

                guard let data = data, let strongSelf = self else {
                    promise.failure(.noData)
                    return
                }

                do {
                    let decoded = try strongSelf.decoder.decode(T.self, from: data)
                    promise.success(decoded)
                } catch {
                    promise.failure(.decoding(error))
                    return
                }
            }
        }
        .resume()
        return promise.future
    }
}
