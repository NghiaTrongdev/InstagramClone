//
//  StorageManager.swift
//  Instagram
//
//  Created by Trọng Nghĩa Nguyễn on 29/02/2024.
//

import FirebaseStorage

public class StorageManager{
    public enum StorageError :Error {
        case failedToDownLoad
    }
    static let shared = StorageManager()
    
    public let database = Storage.storage().reference()
    
//    public func upLoadUserPhoto(model : UserPost,completion : @escaping  (Result<URL,Error>)-> Void){
//        
//    }
    public func downloadImage (with reference : String , completion :@escaping (Result<URL ,StorageError>)->Void){
        database.child(reference).downloadURL(completion: {url, error in
            guard let url = url , error == nil else {
                completion(.failure(.failedToDownLoad))
                return
            }
            completion(.success(url))
        })
    }
    
    
    
    
}

