//  ___FILEHEADER___


import UIKit
import RealmSwift

private protocol LocalDelegate {
    
    associatedtype T : Object
    
    func save(_ obj : T)
    func saveAll(_ objs : [T])
    func delete(_ obj : T)
    func deleteBy(_ id : Int)
    func deleteBy(_ id : String)
    func update(_ obj : T)
    func update(obj : T ,closure : () -> Void)
    func clearAll()
    func getAll() -> List<T>
    func getAll(sortKey : String, ascending : Bool) -> List<T>
    func getResults() -> Results<T>?
    func getObjects(_ limit : Int,sortedKey : String) -> List<T>
    func getObjects(where query : String , limit : Int,sortedKey : String) -> List<T>
    func getById(_ id : Int) -> T?
    func getById(_ id : String) -> T?
    func getBy(key : String , value : String) -> T?
    
    
    func getObjects(_ query : String) -> List<T>
    func notifyDataChange(change : @escaping (RealmCollectionChange<Results<T>>) -> Void)
    
    var counts : Int { get set }
    func getLastObject(key : String) -> T?    
}


class Local<T:Object> : LocalDelegate {
    
    
    var counts: Int {
        set {
            _ = newValue
        }
        get {
            return realm?.objects(T.self).count ?? 0
        }
    }
    
    
    private var realm = Database.shared.realm
    
    //MARK:GET ALL OBJECT
    func getAll() -> List<T>{
        
        let results = List<T>()
        if let objects = realm?.objects(T.self) {
            for obj in objects {
                results.append(obj)
            }
        }
        
        return results
        
    }
    
    
    //MARK:GET OBJECT BY ID
    func getById(_ id: Int) -> T? {
   
        return realm?.object(ofType: T.self, forPrimaryKey: id)
    }
    func getById(_ id: String) -> T? {
      
        return realm?.object(ofType: T.self, forPrimaryKey: id)
    }
    
    
    //MARK: SAVE
    func save(_ obj : T) {
        
        try? realm?.write{
            
            realm?.add(obj, update: .modified)
            
        }
        
    }
    //MARK: SAVE ALL OBJECT
    func saveAll(_ objs : [T]){
        
        try? realm?.write{
            
            realm?.add(objs, update: .modified)
            
        }
    }
    
    
    
    
    //MARK: DELETE BY OBJECT
    func delete(_ obj : T) {
        try? realm?.write{
            realm?.delete(obj)
        }
    }
    
    
    
    //MARK: DELETE BY ID
    func deleteBy(_ id: Int) {
        guard let obj = realm?.object(ofType: T.self, forPrimaryKey: id) else {
            return
        }
        delete(obj)
    }
    func deleteBy(_ id: String) {
        guard let obj = realm?.object(ofType: T.self, forPrimaryKey: id) else {
            return
        }
        delete(obj)
    }
    
    
    //MARK: UPDATE OBJECT
    func update(_ obj : T) {
        try? realm?.write {
            realm?.add(obj, update: .modified)
        }
    }
    
    func update(obj : T , closure : () -> Void) {
        try? realm?.write {
            closure()
            realm?.add(obj, update: .modified)
        }
    }
    
    
    
    
    //MARK: CLEAR ALL OBJECT
    func clearAll() {
        
        guard let objs = realm?.objects(T.self) else {
            return
        }
        
        try? realm?.write{
            realm?.delete(objs)
        }
    }
    
    
    //MARK: GET OBJECT BY KEY-VAULE
    func getBy(key: String, value: String) -> T? {
        return realm?.objects(T.self).filter("\(key) == '\(value)'").first
    }
    
    
    func getObjects(_ query: String) -> List<T> {
        let results = List<T>()
//        //debugPrint("Test ",query)
        if let objects = realm?.objects(T.self).filter(query) {
            for obj in objects {
                results.append(obj)
            }
        }
        
        return results
    }
    
    
    
    
    //MARK: NOTIFY DATA CHANGE
    var token: NotificationToken?
    func notifyDataChange(change : @escaping (RealmCollectionChange<Results<T>>) -> Void) {
        token = realm?.objects(T.self).observe({ (observe) in
            change(observe)
        })
    }
    
    
    //    MARK: Get Last Object
    func getLastObject(key : String) -> T? {
        return realm?.objects(T.self).sorted(byKeyPath: key,ascending: false).first
    }
    
    //  MARK: Get Objects Limits
    func getObjects(_ limit: Int , sortedKey : String ) -> List<T> {
        let results = List<T>()
        var count = limit
        if let objects = realm?.objects(T.self).sorted(byKeyPath: sortedKey, ascending: false) {
            
            if objects.count < count {
                count = objects.count
            }
            for i in 0..<count {
                results.append(objects[i])
            }
        }
        
        return results
    }
    
    
    func getObjects(where query: String, limit: Int, sortedKey: String) -> List<T> {
        
        let results = List<T>()
        var count = limit
        if let objects = realm?.objects(T.self).filter(query).sorted(byKeyPath: sortedKey, ascending: false) {
            
            if objects.count < count {
                count = objects.count
            }
            for i in 0..<count {
                results.append(objects[i])
            }
        }
        
        return results
        
        
    }
    
    func getResults() -> Results<T>? {
        return realm?.objects(T.self)
    }
        

    
}



extension Local {
    
    func getAll(sortKey: String , ascending : Bool = true) -> List<T> {
        let results = List<T>()
        
        if let objects = realm?.objects(T.self).sorted(byKeyPath: sortKey, ascending: ascending) {
            for obj in objects {
                results.append(obj)
            }
        }
        
        return results
    }
}

