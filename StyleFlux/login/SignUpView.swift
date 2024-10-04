//
//  SignUpView.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-09-06.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var fullName = ""
    @State private var password = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authVM: AuthenticationVM
    
    var body: some View {
        VStack{
            inputView(text: $email, title: "Email Address",
                      placeholder: "Enter Email Address")
            .autocapitalization(.none)
            .textInputAutocapitalization(.never)
            
            inputView(text: $fullName, title: "Full Name",
                      placeholder: "Enter Your Name")
    
            
            inputView(text: $password, title: "Password",
                      placeholder: "Enter Password",
                      isSecureField: true)
            
            
        }
        .padding(.horizontal)
        
        
        Button{
            Task{
                try await  authVM.createUser(withEmail: email,
                                             password: password,
                                             fullname: fullName)
            }
            
            
        } label: {
            HStack{
                Text("SIGN UP")
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
        
        Button{
            dismiss()
            
        }label: {
            HStack{
                Text("Already have an Account?")
                Text("Sign in")
                    .fontWeight(.semibold)
            }
        }
    }
}

#Preview {
    SignUpView()
}
