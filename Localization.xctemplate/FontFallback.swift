//  ___FILEHEADER___

import Foundation
import UIKit

@objc public extension UIFont {
    convenience init(names: [String], size: CGFloat) {
        
        if names.first != nil {
            let mainFontName = names.first!
            
            let descriptors = names.map { UIFontDescriptor(fontAttributes: [.name: $0]) }
            
            let attributes: [UIFontDescriptor.AttributeName: Any] = [
                UIFontDescriptor.AttributeName.cascadeList: descriptors,
                UIFontDescriptor.AttributeName.name: mainFontName,
                UIFontDescriptor.AttributeName.size: size,
                ]
            
            let customFontDescriptor: UIFontDescriptor = UIFontDescriptor(fontAttributes: attributes)
            self.init(descriptor: customFontDescriptor, size: size)
        }
        else{
            let systemFont = UIFont.systemFont(ofSize: size)
            let systemFontDescriptor: UIFontDescriptor = systemFont.fontDescriptor
            self.init(descriptor: systemFontDescriptor, size: size)
        }
    }
    
    convenience init(families: [String], size: CGFloat) {
        
        if families.first != nil {
            let mainFontFamily = families.first!
            let descriptors = families.map { UIFontDescriptor(fontAttributes: [.family: $0]) }
            
            let attributes: [UIFontDescriptor.AttributeName: Any] = [
                UIFontDescriptor.AttributeName.cascadeList: descriptors,
                UIFontDescriptor.AttributeName.family: mainFontFamily,
                UIFontDescriptor.AttributeName.size: size
            ]
            
            let customFontDescriptor: UIFontDescriptor = UIFontDescriptor(fontAttributes: attributes)
            self.init(descriptor: customFontDescriptor, size: size)
        }
        else{
            let systemFont = UIFont.systemFont(ofSize: size)
            let systemFontDescriptor: UIFontDescriptor = systemFont.fontDescriptor
            self.init(descriptor: systemFontDescriptor, size: size)
        }
    }
    
    @available(iOS 8.2, *)
    convenience init(families: [String], size: CGFloat, weight: UIFont.Weight = .regular) {
        
        if families.first != nil {
            let mainFontFamily = families.first!
            let descriptors = families.map { UIFontDescriptor(fontAttributes: [.family: $0]) }
            let traits = [UIFontDescriptor.TraitKey.weight: weight]
            
            let attributes: [UIFontDescriptor.AttributeName: Any] = [
                UIFontDescriptor.AttributeName.cascadeList: descriptors,
                UIFontDescriptor.AttributeName.family: mainFontFamily,
                UIFontDescriptor.AttributeName.size: size,
                UIFontDescriptor.AttributeName.traits: traits
            ]
            
            let customFontDescriptor: UIFontDescriptor = UIFontDescriptor(fontAttributes: attributes)
            self.init(descriptor: customFontDescriptor, size: size)
        }
        else{
            let systemFont = UIFont.systemFont(ofSize: size, weight: weight)
            let systemFontDescriptor: UIFontDescriptor = systemFont.fontDescriptor
            self.init(descriptor: systemFontDescriptor, size: size)
        }
    }
}

@objc public extension NSMutableAttributedString {
    
    /// - Parameter text
    /// - Parameter families
    /// - Parameter size
    /// - Parameter weight
    /// - Parameter kern
    /// - Parameter paragraphStyle
    /// - Parameter fallback
    /// - Returns
    convenience init(text: String, names: [String], size: CGFloat, kern: CGFloat = 0.0, paragraphStyle: NSParagraphStyle? = nil, fallback: String? = nil){
        let font = UIFont(names: names, size: size)
        var attributes = Dictionary<NSAttributedString.Key , Any>()
        attributes[NSAttributedString.Key.font] = font
        if kern > 0 {
            attributes[NSAttributedString.Key.kern] = kern
        }
        if paragraphStyle != nil {
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        if fallback != nil {
            let languages = Locale.preferredLanguages
            if languages.contains(fallback!) {
                attributes[NSAttributedString.Key(rawValue: kCTLanguageAttributeName as String as String)] = fallback
            }
        }
        let attributedString = NSMutableAttributedString(string: text, attributes:attributes)
        self.init(attributedString: attributedString)
    }
    
    /// - Parameter text
    /// - Parameter families
    /// - Parameter size
    /// - Parameter weight
    /// - Parameter kern
    /// - Parameter paragraphStyle
    /// - Parameter fallback
    /// - Returns
    convenience init(text: String, families: [String], size: CGFloat, kern: CGFloat = 0.0, paragraphStyle: NSParagraphStyle? = nil, fallback: String? = nil){
        let font = UIFont(families: families, size: size)
        var attributes = Dictionary<NSAttributedString.Key , Any>()
        attributes[NSAttributedString.Key.font] = font
        if kern > 0 {
            attributes[NSAttributedString.Key.kern] = kern
        }
        if paragraphStyle != nil {
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        if fallback != nil {
            let languages = Locale.preferredLanguages
            if languages.contains(fallback!) {
                attributes[NSAttributedString.Key(rawValue: kCTLanguageAttributeName as String as String)] = fallback
            }
        }
        let attributedString = NSMutableAttributedString(string: text, attributes:attributes)
        self.init(attributedString: attributedString)
    }
    
    /// - Parameter text
    /// - Parameter families
    /// - Parameter size
    /// - Parameter weight
    /// - Parameter kern
    /// - Parameter paragraphStyle
    /// - Parameter fallback
    /// - Returns
    @available(iOS 8.2, *)
    convenience init(text: String, families: [String], size: CGFloat, weight: UIFont.Weight = .regular, kern: CGFloat = 0.0, paragraphStyle: NSParagraphStyle? = nil, fallback: String? = nil){
        let font = UIFont(families: families, size: size, weight: weight)
        var attributes = Dictionary<NSAttributedString.Key , Any>()
        attributes[NSAttributedString.Key.font] = font
        if kern > 0 {
            attributes[NSAttributedString.Key.kern] = kern
        }
        if paragraphStyle != nil {
            attributes[NSAttributedString.Key.paragraphStyle] = paragraphStyle
        }
        if fallback != nil {
            let languages = Locale.preferredLanguages
            if languages.contains(fallback!) {
                attributes[NSAttributedString.Key(rawValue: kCTLanguageAttributeName as String as String)] = fallback
            }
        }
        let attributedString = NSMutableAttributedString(string: text, attributes:attributes)
        
        self.init(attributedString: attributedString)
    }
}
