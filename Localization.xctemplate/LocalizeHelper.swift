//  ___FILEHEADER___

import Foundation

enum Language: String {
    case khmer = "km"
    case english = "en"
}

class LocalizeHelper: NSObject {
    
    static let localSystem = LocalizeHelper()
    
    static var currentLanguage : Language {
        get {
            return getCurrentLanguage()
        }
    }
    
    private var myBundle: Bundle = .main
    
    override init() {
        super.init()
        self.setLanguage(getCurrentLanguage())
    }
    
    func localizedString(forKey key: String) -> String {
        return (myBundle.localizedString(forKey: key, value: "", table: nil))
    }
    
    
    func setLanguage(_ lang: Language) {
        saveLanguagePrefix(lang.rawValue)
        if let path = Bundle.main.path(forResource: lang.rawValue, ofType: "lproj") {
            myBundle = Bundle(path: path) ?? .main
            return
        }
        myBundle = .main
    }
    
    //CURRENT LANGUAGE
    private func saveLanguagePrefix( _ prefix: String) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(prefix, forKey: "language")
        userDefaults.synchronize()
    }
    
    
    //CURRENT LANGUAGE
    private func getCurrentLanguage() -> Language {
        let userDefaults = UserDefaults.standard
        return Language(rawValue: userDefaults.string(forKey: "language") ?? "en") ?? .english
    }
    
    private class func getCurrentLanguage() -> Language {
        let userDefaults = UserDefaults.standard
        return Language(rawValue: userDefaults.string(forKey: "language") ?? "en") ?? .english
    }
    
    class func getSopportedLanguages() -> [String] {
        return [
            "ភាសាខ្មែរ",
            "English"
        ]
    }
}
