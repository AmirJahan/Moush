//
//  CloudError.swift
//  Tasks
//
//  Created by Navpreet Singh on 2023-04-19.
//

import Foundation
enum CloudError: Error
{
    case authError
    case badDataError
    case readError
    case decodingError
    case permissionError
    case noResError
    case erroredResError
    case usernameError
    case badData
    case signUpError
    case loginError
    case userNotLoggedIn
}
