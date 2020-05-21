//  Copyright © 2020 ACartagena. All rights reserved.

import UIKit
import Kingfisher

extension UIImageView {
    func prepareForReuse() {
        kf.cancelDownloadTask()
        image = nil
    }

    func setImage(_ url: URL?, downloadFinished: ((Result<Void, Error>) -> Void)? = nil) {
        guard let url = url else {
            kf.cancelDownloadTask()
            return
        }
        kf.indicatorType = .activity
        kf.setImage(with: url, placeholder: UIImage(named: "placeholder")) { result in
            switch result {
            case .success: downloadFinished?(.success(()))
            case let .failure(error): downloadFinished?(.failure(error))
            }
        }
        sizeToFit()
    }
}
