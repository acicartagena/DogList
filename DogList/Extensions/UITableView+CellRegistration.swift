//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
import UIKit

extension UITableView {
    func register<T>(_ aClass: T.Type) where T: UITableViewCell {
        register(aClass, forCellReuseIdentifier: aClass.reuseIdentifier)
    }

    func dequeCell<T>(for indexPath: IndexPath) -> T where T: UITableViewCell {
        return dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T ?? T()
    }
}
