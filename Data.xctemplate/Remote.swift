//  ___FILEHEADER___

import UIKit
import Alamofire

private protocol RemoteDelegate {
    
    associatedtype T  //Response Type
    
    func request(url : String ,
                 method : HTTPMethod,
                 params : Parameters?,
                 headers : HTTPHeaders?,
                 timeout : Int,
                 debug  :Bool,
                 completion:
        @escaping (Swift.Result<T,JSONError>) -> Void)
    
    func decodeObject(_ data : Data?) -> T?
    
    
    func request(request : URLRequest ,debug : Bool,
                 completion:
        @escaping (Swift.Result<T,JSONError>) -> Void)
    
}


class RemoteDataSource<T:Codable> : RemoteDelegate {
    
    
    let sessionManager: Session = {
      let configuration = URLSessionConfiguration.af.default
      configuration.timeoutIntervalForRequest = 60
      return Session(configuration: configuration)
    }()
    
    
    func request(url: String,
                 method : HTTPMethod = .get,
                 params: Parameters? = nil,
                 headers : HTTPHeaders? = nil,
                 timeout : Int = 60,
                 debug  :Bool = false,
                 completion:
        @escaping (Swift.Result<T, JSONError>) -> Void){
        sessionManager.sessionConfiguration.timeoutIntervalForRequest = TimeInterval(timeout)
        sessionManager.request(url,
                   method: method,
                   parameters: params,
                   headers: headers
        ).responseJSON { (response) in
            if debug {
                debugPrint("DEBUG",response)
            }
            
            switch response.result {
            case .success(let data):
                if let object = self.decodeObject(response.data) {
                    completion(.success(object))
                }else {
                    completion(.failure(.jsonError(data)))
                }
                break
            case .failure(let err):
                completion(.failure(.error(err)))
                break
            }
        }
    }
    
    
    
    func decodeObject(_ data: Data?) -> T? {
        
        guard let data = data else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            
            let object = try decoder.decode(U.self, from: data)
            return object
            
        } catch let err {
            debugPrint("DECODE ERR : ",err)
        }
        return nil
    }
    
    
    func request(request: URLRequest,debug:Bool = false,
                 completion: @escaping (Swift.Result<U, JSONError>) -> Void) {
        AF.request(request).responseJSON { (response) in
            
            if debug {
                debugPrint("DEBUG",response)
            }
            
            switch response.result {
            case .success(let data):
                if let object = self.decodeObject(response.data) {
                    completion(.success(object))
                }else {
                    completion(.failure(.jsonError(data)))
                }
                break
            case .failure(let err):
                completion(.failure(.error(err)))
                break
            }
        }
    }
}
