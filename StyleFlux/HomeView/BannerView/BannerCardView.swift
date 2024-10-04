//
//  BannerCardView.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-08-26.
//

import SwiftUI

struct BannerCardView: View {
    
    private var bannerVM = BannerCardVM()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            
            HStack(spacing: 20) {
                ForEach(bannerVM.items, id: \.id) { bannerCard in
                    ZStack(alignment: .leading) {
                        ThumbView(image: bannerVM.images[bannerCard.imageUrl], height: 450, width: 250)
                            .cornerRadius(5)
                        
                        VStack(alignment: .leading){
                            Spacer()
                            BannerHeading(bannercard: bannerCard)
                            
                            Button(action: {
                                print("Learn More about \(bannerCard.name)")
                            }) {
                                BannerButton()
                            }
                        }
                        .padding()
                    }
                    .frame(width: 250, height: 450)
                }
                .shadow(color: .white.opacity(0.1), radius:2, x: 0, y: 5)
            }
            .padding()
        }
    }
}

struct BannerHeading: View {
    var bannercard: BannerCard
    
    var body: some View {
        
        VStack{
            Text(bannercard.name)
                .font(.title3)
                .frame(width: 150)
                .padding(5)
                .background(Color.black.opacity(0.4))
                .cornerRadius(2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
    }
}

struct BannerButton: View {
    var body: some View {
        Text("Shop Now")
            .font(.subheadline)
            .foregroundColor(.black)
            .padding(.vertical, 8)
            .padding(.horizontal, 20)
            .background(Color.white)
            .cornerRadius(4)
    }
}

#Preview {
    BannerCardView()
}

