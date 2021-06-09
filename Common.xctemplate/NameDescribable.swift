//  ___FILEHEADER___

import UIKit

extension NSObject : NameDescribable{}

protocol NameDescribable {
    var identifier: String { get }
    static var identifier: String { get }
}

extension NameDescribable {
    var identifier: String {
        return String(describing: type(of: self))
    }

    static var identifier: String {
        return String(describing: self)
    }
}
