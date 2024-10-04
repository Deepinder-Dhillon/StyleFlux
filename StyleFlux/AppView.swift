import SwiftUI

struct AppView: View {
    @EnvironmentObject var authVM: AuthenticationVM
    @StateObject  var productIDsManager: CartProductDetailsManager
    
    
    
    var body: some View {
      
                TabView {
                    EquatableView(content: HomeView())
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                            
                            
                }
                        .tag(0)
                    
                    EquatableView(content: ShopView())
                        .tabItem {
                            Image(systemName: "text.magnifyingglass")
                            Text("Shop")
                        }
                        .tag(1)
                    
                    CartView()
                        .tabItem {
                            Image(systemName: "bag")
                            Text("Bag")
                        }
                        .badge(productIDsManager.productDetails.count)
                        .tag(2)
                    
                    EquatableView(content: ProfileView())
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profile")
                        }
                        .tag(3)
                }
                .onAppear {
                    let tabBarAppearance = UITabBarAppearance()
                           tabBarAppearance.configureWithOpaqueBackground()
                           tabBarAppearance.backgroundColor = UIColor.black
                           UITabBar.appearance().standardAppearance = tabBarAppearance
                           UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                    tabBarAppearance.stackedLayoutAppearance.normal.badgeBackgroundColor = UIColor(Color.lightGreen)
                            }
                .tint(.lightGreen)
        
        
                .environmentObject(productIDsManager)
            }
            
 
}

#Preview {
    AppView(productIDsManager: CartProductDetailsManager(userID: "CfAucUKEFKg5y0nLFKqVJWabFC13"))
        .environmentObject(AuthenticationVM())
}







