//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation

class Networking {
    let session = URLSession(configuration: .default)
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, DogListError>) -> Void) {
        session.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.networking(error)))
                    return
                }

                guard let data = data, let strongSelf = self else {
                    completion(.failure(.noData))
                    return
                }

                do {
                    let decoded = try strongSelf.decoder.decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(.decoding(error)))
                    return
                }
            }
        }
        .resume()
    }
}
