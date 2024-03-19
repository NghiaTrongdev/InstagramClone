//
//  AutheManager.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 29/02/2024.
//

import FirebaseAuth

public class AuthManager{
    static let shared = AuthManager()
    
    public func registerUser(username:String , email:String,password:String, completion : @escaping (Bool) -> Void){
     // check is valid
        
        // create accout
        // insert account to database
        DatabaseManager.shared.canCreateAccount(with: email, username: username, password: password) {success in
            if success {
                Auth.auth().createUser(withEmail: email, password: password) {result , error in
                    guard result != nil , error == nil else  {
                        return
                    }
                    DatabaseManager.shared.insertNewUser(with: email, username: username){success in
                        if success {
                            completion(true)
                            return
                        } else {
                            completion(false)
                        }
                            
                    }
                    
                }
            }
        }
        
    }
    
    public func loginUser(username :String?, email : String?,password :String, completion :@escaping (Bool) -> Void){
        if let email = email {
            // email login
            Auth.auth().signIn(withEmail: email, password: password){ authResult , error in
                guard authResult != nil , error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        }
        else if let username = username {
            // username login
            print(username)
        }
        
    }
    public func logOut(completion : (Bool) -> Void){
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch{
            print(error)
            completion(false)
            return
        }
    }
}
