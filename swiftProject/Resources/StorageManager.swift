//
//  StorageManager.swift
//  newEssayProject
//
//  Created by Elıf on 5.06.2022.
//

import Foundation
import Firebase
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    private init() {}
    private let storage = Storage.storage().reference()
 
    
    public typealias UploadPictureCompletion = (Result<String, Error>) -> Void
    //Uploads pic to firebase storage and returns completion with url string to dowload
    public func uploadProfilePicture(with data: Data,
                                     fileName: String,
                                     completion: @escaping UploadPictureCompletion) {
        storage.child("images/\(fileName)").putData(data, metadata: nil, completion: { metadata, error in
            guard error == nil else {
                //failed
                print("failed to upload data to firebase for profile picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            self.storage.child("images/\(fileName)").downloadURL(completion: {url, error in
                guard let url = url else {
                    print("Failed to get dowload url")
                    completion(.failure(StorageErrors.failedToGetDowloadUrl))
                    return
                }
                let urlString = url.absoluteString
                print("dowload url returned: \(urlString)")
                completion(.success(urlString))
            })
        })
    }
    //Upload image that will be sent in a conversation message
    public func uploadMessagaPhoto(with data: Data,
                                     fileName: String,
                                     completion: @escaping UploadPictureCompletion) {
        storage.child("message_images/\(fileName)").putData(data, metadata: nil, completion: { metadata, error in
            guard error == nil else {
                //failed
                print("failed to upload data to firebase for profile picture")
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            self.storage.child("message_images/\(fileName)").downloadURL(completion: {url, error in
                guard let url = url else {
                    print("Failed to get dowload url")
                    completion(.failure(StorageErrors.failedToGetDowloadUrl))
                    return
                }
                let urlString = url.absoluteString
                print("dowload url returned: \(urlString)")
                completion(.success(urlString))
            })
        })
    }
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDowloadUrl
    }
    
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void){
        let reference = storage.child(path)
        
        reference.downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageErrors.failedToGetDowloadUrl))
                return
            }
            completion(.success(url))
        })
    }
}
