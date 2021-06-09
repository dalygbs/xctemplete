//  ___FILEHEADER___

import UIKit

enum Storyboard : String {
    case main = "Main"
}


class Navigation {
    
    
    private class func getStoryBoard(in sb : Storyboard) -> UIStoryboard {
        return UIStoryboard.init(name: sb.rawValue , bundle: nil)
    }

    //GET VIEW CONTROLLER
    class func getViewController<T:UIViewController>(in sb : Storyboard = .main) -> T {
        let vc =  getStoryBoard(in:sb).instantiateViewController(withIdentifier: T.identifier) as! T
        return vc
    }
    
}
