//
//  AutheManager.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 29/02/2024.
//

import FirebaseAuth

public class AuthManager{
    static let shared = AuthManager()
    
    public func registerUser(username:String , email:String,password:String){
        
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
}
