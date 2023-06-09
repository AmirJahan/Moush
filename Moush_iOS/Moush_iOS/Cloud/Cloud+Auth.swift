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
    func signUp(
        email: String,
        name: String,
        password: String,
        bday: String,
        completion: @escaping (Result<AuthDataResult, CloudError>) -> Void
    ) {
        myAuth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(.signUpError))
                return
            }
            
            guard let user = authResult?.user else {
                completion(.failure(.signUpError))
                return
            }
            
            let userRef = Cloud.inst.ref.child("users").child(user.uid)
            
            let userInfo: [String: Any] = [
                "name": name,
                "email": email,
                "birthday": bday
            ]
            
            userRef.setValue(userInfo) { error, _ in
                if let error = error {
                    completion(.failure(.signUpError))
                } else {
                    completion(.success(authResult!))
                }
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<AuthDataResult, CloudError>) -> Void)
    {
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

