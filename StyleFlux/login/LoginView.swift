//
//  LoginView.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-09-06.
//

import SwiftUI



struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var authVM: AuthenticationVM
    
    var body: some View {
        
        NavigationStack{
            
            Spacer()
            VStack{
            
                inputView(text: $email, title: "Email Address",
                          placeholder: "Enter Email Address")
                .autocapitalization(.none)
                .textInputAutocapitalization(.never)
                
                
                inputView(text: $password, title: "Password",
                          placeholder: "Enter Password",
                          isSecureField: true)
                
            
                
            }
            .padding(.horizontal)
            
            
            Button{
                Task{
                  try await authVM.signIn(withEmail: email, password: password)
                }
                
            } label: {
                HStack{
                    Text("SIGN IN")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
            
            Spacer()
            
            NavigationLink{
                SignUpView()
                
            } label: {
                HStack{
                    Text("Dont have account?")
                    Text("Sign Up")
                        .fontWeight(.semibold)
                }
            }
            
            
        }
    }
}


struct inputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .fontWeight(.semibold)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
        
            } else {
                TextField(placeholder, text: $text)
                
            }
            
            Divider()
        }

    }
}



#Preview {
    LoginView()
}
