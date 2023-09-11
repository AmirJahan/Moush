import SwiftUI
import Firebase
struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var birthdate: String = ""
    
    @State private var success: String = ""
    
    @State private var navigateToHomeScreen : Bool = false
    
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .padding(.bottom, 40)
                
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.headline)
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Text("Email")
                        .font(.headline)
                        .padding(.top)
                    TextField("Email", text: $email)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Text("Password")
                        .font(.headline)
                        .padding(.top)
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Text("Birthday")
                        .font(.headline)
                        .padding(.top)
                    TextField("Birthdate", text: $birthdate)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                }
                .padding()
                
                Button("Sign Up")
                {
                    success = ""
                    
                    // call signUp on button click, also checks if the user already exists
                    Cloud.inst.signUp(email: email, name: name, password: password, bday: birthdate){ res in
                        switch res
                        {
                        case .success(let authResult):
                            success = "success"
                        case .failure(_):
                            success = "Failed"
                        }
                    }
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(8)
                
                Text(success)
                    .font(.headline)
                    .padding(.top)
                
            }
            .padding()
        }
    }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
