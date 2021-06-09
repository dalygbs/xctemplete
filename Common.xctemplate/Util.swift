//  ___FILEHEADER___

import Foundation

class AppUtil {

    class func isFirstLaunchApp() -> Bool {
        let userDefault = UserDefaults.standard
        return !userDefault.bool(forKey: "first_launch_app")
    }
    
    class func initFirstLaunchApp()  {
        let userDefault = UserDefaults.standard
        userDefault.setValue(true, forKey: "first_launch_app")
        userDefault.synchronize()
    }
    
}
