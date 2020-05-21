//  Copyright © 2020 ACartagena. All rights reserved.

import Foundation
import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
