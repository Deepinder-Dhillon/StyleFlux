//
//  ProfileView.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-08-28.
//

import SwiftUI
import Firebase
import FirebaseAuth



struct ProfileView: View, Equatable {
    @EnvironmentObject var authVM: AuthenticationVM
    
    static func == (lhs: ProfileView, rhs: ProfileView) -> Bool {
        true
    }
 
    var body: some View {
        
        
        //        if let user =  authVM.currentUser
        let user = User(id: NSUUID().uuidString, fullname: "Deepinder Dhillon", email: "Test@gmail.com", cartDetails: [:])
        
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.3, green: 0.3, blue: 0.32), Color(red: 0.01, green: 0.01, blue: 0.013)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            
            VStack (alignment: .leading){
                
                HStack{
                    Text(user.intials)
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.lightGreen)
                        .padding()
                        .background(Color.black)
                        .clipShape(Circle())
                    VStack(alignment: .leading, spacing: 4){
                        Text(user.fullname)
                        Text(user.email)
                            .font(.footnote)
                    }
                    .foregroundColor(.white)
                    Spacer()
                      
                   
                }
                
                VStack(alignment: .leading, spacing: 15){
                    
                    
                    
                    Button{
                        authVM.signOut()
                        
                    } label: {
                        ProfileButtons(title: "My Orders", icon: "bag.fill")
                    }
                    
                    Button{
                        authVM.signOut()
                        
                    } label: {
                        ProfileButtons(title: "favourties", icon: "heart.fill")
                    }
                    
                    Button{
                        authVM.signOut()
                        
                    } label: {
                        ProfileButtons(title: "Sign Out", icon: "door.right.hand.open")
                    }
                    
                }
                .padding(.top)
                Spacer()
                 
            }
            .padding()
            
           
        }
        
        
    }
}

struct ProfileButtons: View {
    let title: String
    let icon: String
    
    var body: some View {

        HStack{
            Image(systemName: icon)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.lightGreen)
            
            Text(title)
            
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            Spacer()
        }
        .padding()
        .background(Color.lightBlack)
        .cornerRadius(6)
        
        
    }
}




#Preview {
    ProfileView()
        .environmentObject(AuthenticationVM())
    
}
