//
//  HomeView.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-08-27.
//

import SwiftUI

struct HomeView: View, Equatable {
    
    static func == (lhs: HomeView, rhs: HomeView) -> Bool {
        true
    }
    
    var body: some View {
       
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.3, green: 0.3, blue: 0.32), Color(red: 0.01, green: 0.01, blue: 0.013)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            
    
            
            VStack{
                SearchIcon()
   
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        WelcomeHeader()
                        BannerCardView()
                            .padding(.bottom)
                        TrendingView()
                        
                        
                        HStack{
                            Text("Most Popular")
                                .padding()
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                            
                            Button{
                                
                            } label: {
                                Text("see all")
                                    .foregroundColor(.lightGreen)
                            }
                            .padding(.trailing)
                        }
                        MostPopularScrollView()
                 
                    }
                }
            }
        }
    }
}

struct SearchIcon: View {
    var body: some View {
        HStack{
            Spacer()
            Button{
                print("search button pressed")
                
            } label: {
                Image(systemName: "magnifyingglass.circle.fill")
                    .foregroundColor(.lightGreen)
                    .font(.title)
         
            }
            .padding(.trailing)
        }
    }
}

struct WelcomeHeader: View {
    var body: some View {
        HStack {
            Text("Welcome")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Spacer()
            
        }
        .padding(.horizontal)
    }
}

struct MostPopular :Codable , Identifiable{
    let id: String
    let name: String
    let price: String
    let imageUrl: String

}

class MostPopularVM: FetchData<MostPopular> {
    
    override init() {
        super.init()
        Task {
            await fetchData(from: "MostPopular")
            await fetchImages()
        }
    }
    
    func fetchImages() async {
        for mostPopular in items {
            await loadImage(for: mostPopular, from: mostPopular.imageUrl)
        }
    }
}


struct MostPopularScrollView: View {
    private var mostPopularVM = MostPopularVM()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 20) {
                ForEach(mostPopularVM.items, id: \.id) { mostpopular in
                    VStack(alignment: .leading) {
                        ThumbView(image: mostPopularVM.images[mostpopular.imageUrl], height: 200)
                            .cornerRadius(5)
                            .shadow(color: .white.opacity(0.1), radius: 5, x: 0, y: 5)
                        
                        Text("\(mostpopular.name)")
                            .font(.headline)
                            .fontWeight(.medium)
                            .padding(.leading)
                        
                        Text("$\(mostpopular.price)")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(Color.gray)
                            .padding(.leading)
                            
        
                    }
                    .foregroundColor(.white)
            
        
                }
                
            }
            .padding(.leading)
            
            
        }
    }
}



#Preview {
    HomeView()
    
    
}
