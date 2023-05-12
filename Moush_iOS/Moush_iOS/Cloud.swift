import Foundation
import Firebase

class Cloud
{
    // instance
    static let inst = Cloud()
    var ref : DatabaseReference!
    var myAuth : Auth!
    
    // I make this singleton so I can have the initial setup here.
    public init ()
    {
        ref = Database.database().reference()
        FirebaseApp.configure()
        myAuth = Auth.auth()
    }
}
