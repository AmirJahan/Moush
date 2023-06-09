//
//  Login.swift
//
//  Created by Navpreet Singh on 2023-05-05.
//

import SwiftUI
import Foundation

struct LoginView: View
{
    @State
    private var email: String = ""
    
    @State
    private var password: String = ""
    
    @State var success: String = ""
    
    
    @State private var navigateToUploadSVG = false
    

    var body: some View{
        
        NavigationView{
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding(.bottom, 40)
                
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.headline)
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
                }
                .padding()
                
                Button("Login") {
                    success = ""
                    Cloud.inst.login(email: email, password: password) { res in
                        switch res
                        {
                        case .success(let authResult):
                            success = "success"
                            navigateToUploadSVG = true
                            
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
                .padding()
                
                Button(action: {})
                {
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                    
                }
                .padding()
                Text(success)
                    .font(.headline)
                    .padding(.top)
                
            }
            .padding()
            .background(
                NavigationLink(destination: UploadSvg().navigationBarBackButtonHidden(true), isActive: $navigateToUploadSVG) {
                    EmptyView()
                }
            )
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

