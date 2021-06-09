//  ___FILEHEADER___


import Alamofire

enum JSONError :  Error {
    case jsonError(Any)
    case error(AFError)
    case noData
}

enum CSError : String , Error {
    
    case SERVER_ERROR = "server_error"
    
    case NO_CONNECTION = "no_connection"
    
    case INCORRECT_PASSCODE = "incorrect_passcode"
    
    case PASSCODE_NOT_MATCH = "passcode_not_match"
    
    case INCORRECT_PASS_OR_USERNAME = "incorrect_pass_or_username"
    
    case JSON_RESPONSE_ERROR = "response_error"
    
    case SOMETHING_WENT_WRONG = "something_weng_wrong"
    
    case FAILED_TO_CREATE_PASSCODE = "failed_to_create_passcode"
        
}

enum CSValidation : String {
    case MISSING_FIELD = "missing_field"
    case VALID = "valid"
}
