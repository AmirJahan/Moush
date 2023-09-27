//
//  Cloud+homeScreen.swift
//  Moush_iOS
//
//  Created by Navpreet Singh on 2023-06-21.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import Firebase

extension Cloud
{
    // fetch all the stored files form the database from the storage
    func fetchImage(fromPath path: String, completion: @escaping (Data?, Error?) -> Void)
    {
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child(path)
        //
        print("Fetching from Firebase Storage path: \(fileRef)")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        fileRef.getData(maxSize: 100 * 1024 * 1024) { data, error in
            if let error = error
            {
                completion(nil, error)
            }
            else
            {
                completion(data, nil)
                if let data = data
                {
                    self.imageArray.append(UIImage(data: data)!)
                    print(self.imageArray.count)
                }
            }
        }
    }
    
    
    
    
    // fetch all the stored files form the database from the storage
    func fetchSvg(fromPath path: String, completion: @escaping (Data?, Error?) -> Void)
    {
        let storageRef = Storage.storage().reference()//
        let fileRef = storageRef.child(path)
        //
        print("Fetching from Firebase Storage path: \(fileRef)")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        fileRef.getData(maxSize: 100 * 1024 * 1024) { data, error in
            if let error = error
            {
                completion(nil, error)
            }
            else
            {
                completion(data, nil)
            }
        }
    }
    
    func fetchUploadedFiles(completion: @escaping (Result<[MySvg], Error>) -> Void)
    {
        
        guard let uid = Cloud.inst.myAuth.currentUser?.uid else//
        {
            completion(.failure(NSError(domain: "CloudError", code: 1001, userInfo: [NSLocalizedDescriptionKey: "User not authenticated"])))
            return
        }
        
        // Reference to the Firestore database
        let db = Firestore.firestore()
        
        // Fetching the documents from the user's collection
        db.collection("\(uid)").getDocuments
        {
            (snapshot, error) in
            
            if let error = error
            {
                print("Firestore error: \(error)")
                completion(.failure(error))
                return
            }
            
            guard let documents = snapshot?.documents else
            {
                print("No documents found for user \(uid)")
                completion(.failure(NSError(domain: "CloudError", code: 1002, userInfo: [NSLocalizedDescriptionKey: "No documents found"])))
                return
            }
            
            print("Fetched \(documents.count) documents for user \(uid)")
            
            // Transforming the documents into the MySvg struct
            let svgs: [MySvg] = documents.compactMap
            {
                document in
                
                let data = document.data()
                
                guard let fileName = data["fileName"] as? String,
                      let authorName = data["authorName"] as? String,
                      let filePath = data["filePath"] as? String else
                {  // Ensure we fetch the filePath
                    return nil
                }
                
                let thumbName = fileName
                print("Data fetch for fileName: \(fileName), thumbName: \(thumbName), author: \(authorName), filePath: \(filePath) succeeded")
                
                return MySvg(fileName: fileName, thumbName: thumbName, author: authorName, tags: [], rating: 0.0, filePath: filePath)
            }
            
            completion(.success(svgs))
        }
    }
}
