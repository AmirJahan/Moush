//
//  Cloud+Google.swift
//  Moush_iOS
//
//  Created by Navpreet Singh on 2023-06-02.
//

import Foundation
import SwiftUI
import GoogleSignIn
import GoogleAPIClientForREST_Drive

class GoogleDrive {
    static let inst = GoogleDrive()

    func uploadFile(name: String, folderID: String, fileURl: URL, service: GTLRDriveService) {
    }
}

struct GoogleDriveView: View {
    var body: some View {
        GoogleSignInButton(action: handleSignInButton)
    }

    let window = UIWindow()

    func handleSignInButton() {
        GIDSignIn.sharedInstance.signIn(withPresenting: UIViewController()) { signInResult, error in
            guard let result = signInResult else {
                // Inspect error
                return
            }
            // If sign in succeeded, display the app's main content View.
        }
    }
}

struct GoogleDriveView_Previews: PreviewProvider {
    static var previews: some View {
        GoogleDriveView()
    }
}
