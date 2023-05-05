//
//  Login.swift
//  Moush_iOS
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
    
    var body: some View{
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
                
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(8)
            .padding()
        }
        .padding()
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

