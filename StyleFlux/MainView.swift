//
//  MainView.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-09-06.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authVm: AuthenticationVM
    
    var body: some View {
        Group{
            if authVm.userSession != nil {
                if let userID = authVm.currentUser{
                    AppView(productIDsManager: CartProductDetailsManager(userID: userID.id))
                }
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    MainView()
}
