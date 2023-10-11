import Foundation
import GoogleSignIn

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     open url: URL,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        //code here
        
        //sign into gogle
        var handled: Bool = GIDSignIn.sharedInstance.handle(url)
        if handled{
            return true
        }
        
        return false
    }
}
