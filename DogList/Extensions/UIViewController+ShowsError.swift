//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
import UIKit

protocol ShowsError {
    func showError(message: String)
}

extension UIViewController: ShowsError {
    func showError(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
