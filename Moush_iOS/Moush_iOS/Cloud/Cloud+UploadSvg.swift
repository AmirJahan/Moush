//
//  Cloud+UploadSvg.swift
//  Moush_iOS
//
//  Created by Navpreet Singh on 2023-05-17.
//

import Foundation
import FirebaseStorage
import FirebaseFirestore
import Firebase

extension Cloud
{
    func uploadFile(fileURL: URL, svg: MySvg, completion: @escaping (Result<String, Error>) -> Void)
    {
        // Storing file in firebase storage
        let storage    = Storage.storage()
        let storageRef = storage.reference()
        
        let uid    = UUID().uuidString
        let fileId = String(uid.suffix(7))

        guard let uid = Cloud.inst.myAuth.currentUser?.uid else { return }

        let fileRef = storageRef.child("\(uid)/\(fileId).svg")
        
        // uploading file reference to the firestore database
        _ = fileRef.putFile(from: fileURL, metadata: nil)
        // FileRef is also available to save but we are not using it atm
        {
            metadata, error in
            
            guard let _ = metadata else
            {
                if let error = error
                {
                    completion(.failure(error))
                    return
                }
                return
            }

            // store the the file reference in the firestore
            let db = Firestore.firestore()
            db.collection("\(uid)").document("\(fileId)").setData([
                "userId"      : uid,
                "fileName"    : "\(fileId).svg",
                "thumbnail"   : "Thumbnails/\(fileId).svg",
                "filePath"    : "\(uid)/\(fileId).svg",
                "rating"      : 3,
                "ratingCount" : 0,
                "tags"        : svg.tags,
                "uploadDate"  : Date(),
                "authorName"  : Cloud.inst.myAuth.currentUser?.displayName as Any
            ])
            {
                err in
                
                if let err = err
                {
                    print("Error adding document: \(err)")
                    completion(.failure(err))
                }
                else
                {
                    print("Document added with ID: \(db.collection("user_files").document().documentID)")
                    completion(.success("Success"))
                }
            }
        }
    }
}
