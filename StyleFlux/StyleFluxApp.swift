import SwiftUI
import Firebase

@main
struct StyleFluxApp: App {
    init() {
        setupFirebase()
    }
    
    @StateObject var authVM = AuthenticationVM()
    

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(authVM)
        }
    }
    
    private func setupFirebase() {
        FirebaseApp.configure()
        print("Firebase configured successfully")
    }
}




