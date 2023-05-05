import Foundation
import Firebase

enum CloudError: Error
{
    case authError
    case badDataError
    case readError
    case decodingError
    case permissionError
}




class Cloud
{
    // instance
    static let inst = Cloud()
    
    var myAuth : Auth!
    
    // I make this singleton so I can have the initial setup here.
    public init ()
    {
        FirebaseApp.configure()
        myAuth = Auth.auth()
    }
}
