//  ___FILEHEADER___

import UIKit

private protocol LocalizeDelegate {
    var localText : String? { get set }
}


extension UILabel : LocalizeDelegate {
    @objc var localText: String? {
        get {
            self.text
        }
        set {
            self.text = newValue?.localized()
        }
    }
}



extension UIButton : LocalizeDelegate {
    
    @objc var localText: String? {
        get {
            self.title(for: .normal)
        }
        set {
            UIView.performWithoutAnimation {
                self.setTitle(newValue?.localized(), for: .normal)
            }
        }
    }
}



extension UITextField : LocalizeDelegate {
    
    @objc var localText: String? {
        get {
            self.text
        }
        set {
            self.text = newValue?.localized()
        }
    }
    
    @objc var localPlaceholder: String? {
        get {
            self.placeholder
        }
        set {
            self.placeholder = newValue?.localized()
        }
    }
}


extension UITextView : LocalizeDelegate {
    @objc var localText: String? {
        get {
            self.text
        }
        set {
            self.text = newValue?.localized()
        }
    }
}


extension String {
    func localized() -> String {
        return LocalizeHelper.localSystem.localizedString(forKey: self)
    }
}
