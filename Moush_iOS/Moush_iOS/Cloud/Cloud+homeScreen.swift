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
    // fetch all IDs from the realtime database
    func fetchAllIds(completion: @escaping () -> Void) {
            ref.child("users").observeSingleEvent(of: .value) { (snapshot) in
                guard let value = snapshot.value as? NSDictionary,
                      let userIds = value.allKeys as? [String] else {
                    print("Error retrieving user IDs.")
                    return
                }
                self.userIds = userIds
                completion()
            }
        }

    // fetch the documents from the firestore
    func fetchFirestoreData() {
        fetchAllIds {
            let db = Firestore.firestore()

            for userId in self.userIds
            {
                // go to the database and get all of the docs
                db.collection(userId).getDocuments { (querySnapshot, err) in
                    if let err = err
                    {
                        print("Error getting documents: \(err)")
                    }
                    else
                    {
                        // for all documents received go through all of them and display them or store them, CAVEATS: Still have not finished working on this.
                        // maybe store them in a array
                        for document in querySnapshot!.documents
                        {
                            let fileName = document.documentID
                            self.fetchFile(fromPath: "Thumbnails/\(fileName).jpg") { (data, error) in
                                
                                if let error = error
                                {
                                    print("Error downloading file: \(error)")
                                } else if let data = data
                                {
                                    print("downloaded file: \(data)")
                                    // Do something with `data`
                                }
                            }
                        }
                    }
                }
            }
        }
        
    }

    // fetch all the stored files form the database from the storage
    func fetchFile(fromPath path: String, completion: @escaping (Data?, Error?) -> Void) {
        let storageRef = Storage.storage().reference()
        let fileRef = storageRef.child(path)

        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        fileRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(data, nil)
                if let data = data {
                    self.imageArray.append(UIImage(data: data)!)
                    print(self.imageArray.count)
                }
            }
        }
    }
}
