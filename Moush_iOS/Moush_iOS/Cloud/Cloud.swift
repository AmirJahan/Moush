import Foundation
import Firebase
import FirebaseAuth

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
    case taskSaveError
    case taskFetchError
    case taskUpdateError
    case taskDeletionError
}


// the database has the functionality of making a new user from sign up.
// creating the reference in the realtime database
// uploading files to the storage and save the references in th firestore database.

class Cloud: ObservableObject
{
    // instance
    static let inst = Cloud()
    var ref : DatabaseReference!
    var myAuth : Auth!
    
    var userIds: [String] = []
    
    @Published var imageArray: [UIImage] = []
    
    // I make this singleton so I can have the initial setup here.
    public init ()
    {
        FirebaseApp.configure()
        ref = Database.database().reference()
        myAuth = Auth.auth()
    }
}
