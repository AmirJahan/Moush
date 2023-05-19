//
//  Cloud+UploadSvg.swift
//  Moush_iOS
//
//  Created by Navpreet Singh on 2023-05-17.
//

import Foundation
import FirebaseStorage
import Firebase

extension Cloud
{
    func uploadFile(fileURL: URL, completion: @escaping (Result<URL, Error>) -> Void) {
        // Define a storage reference pointing to the desired storage location.
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let fileRef = storageRef.child("\(globalUid)/\(fileURL.lastPathComponent)")

        // Define the upload task.
        let uploadTask = fileRef.putFile(from: fileURL, metadata: nil) { metadata, error in
            guard let _ = metadata else {
                // An error occurred!
                if let error = error {
                    completion(.failure(error))
                    return
                }
                return
            }

            // Metadata contains file metadata such as size, content-type.
            fileRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    // An error occurred!
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    return
                }

                // The file has successfully been uploaded, and we have the URL.
                completion(.success(downloadURL))
            }
        }
    }
}
