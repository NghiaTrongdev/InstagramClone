//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 29/02/2024.
//

import FirebaseDatabase

public class DatabaseManager{
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    public func canCreateAccount(with email : String, username : String , password : String , completion:  @escaping (Bool) -> Void){
        completion(true)
        
    }
    public func insertNewUser(with email: String , username : String , completion : @escaping (Bool) ->Void){
        database.child(email.safeDatabasekey()).setValue(["username",username]){ error , _ in
            if error == nil{
                completion(true)
                // succes
                return
            } else {
                // fail
                completion(false)
                return
            }
        }
    }
}
