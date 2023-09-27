//
//  Cloud+Auth.swift
//  Tasks
//
//  Created by Navpreet Singh on 2023-04-19.
//

import Foundation
import Firebase

extension Cloud
{
    
    // signUp function checks if the user exists, and creates a new user
    func signUp(
        email: String,
        name: String,
        password: String,
        bday: String,
        completion: @escaping (Result<AuthDataResult, CloudError>) -> Void
    ) {
        
        // go into the database and create the user
        myAuth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error
            {
                completion(.failure(.signUpError))
                return
            }
            
            guard let user = authResult?.user else {
                completion(.failure(.signUpError))
                return
            }
            
            // create a new user in the realtime database to keep the reference of the IDs
            let userRef = Cloud.inst.ref.child("users").child(user.uid)
            
            let userInfo: [String: Any] = [
                "name": name,
                "email": email,
                "birthday": bday
            ]
            
            // create e displayName to make a author for the svgs
            userRef.setValue(userInfo)
            {
                error, _ in
                
                if let error = error
                {
                    completion(.failure(.signUpError))
                }
                else
                {
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = "Your Username"
                    changeRequest?.commitChanges
                    {
                        (error) in
                        // handle error
                    }
                    completion(.success(authResult!))
                }
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<AuthDataResult, CloudError>) -> Void)
    {
        // login to the app
        myAuth.signIn(withEmail: email, password: password){ result, error in
            if let error = error
            {
                completion(.failure(.loginError))
            }
            else if let result = result
            {
                completion(.success(result))
            }
        }
    }
}

