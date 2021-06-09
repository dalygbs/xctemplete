//  ___FILEHEADER___

import Alamofire
import RealmSwift

//LOCAL REPO
protocol ___FILEBASENAMEASIDENTIFIER___LocalRepo {
    
}

//Remote REPO
protocol ___FILEBASENAMEASIDENTIFIER___RemoteRepo {
    
}

class ___FILEBASENAMEASIDENTIFIER___ {
        
    // VARIABLES HERE
    

    /// Replace
    /// Realm___VARIABLE_productName:identifier___  with  your local model
    private let ___VARIABLE_productName:identifier___Local = Local<Realm___VARIABLE_productName:identifier___>()
    
    
    /// Replace
    /// ___VARIABLE_productName:identifier___Response with  your model
    private let ___VARIABLE_productName:identifier___LocalRemote = RemoteDataSource<___VARIABLE_productName:identifier___Response>()
    
    
    init() {}
    
    
}


//LOCAL REPO
extension ___FILEBASENAMEASIDENTIFIER___ : ___FILEBASENAMEASIDENTIFIER___LocalRepo {
    
}


//REMOTE REPO
extension ___FILEBASENAMEASIDENTIFIER___ : ___FILEBASENAMEASIDENTIFIER___RemoteRepo {

}
