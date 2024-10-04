//
//  TrendingView.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-09-02.
//
import Foundation
import Observation
import SwiftUI


struct TrendingView: View {
  let tendingLabels = Label(labels: ["All", "Shirts", "Pants", "Shorts", "Hoodies"])
  let trendingVM = TrendingVM()

  var body: some View {
    
      VStack(alignment: .leading) {
      Text("Trending")
        .font(.title2)
        .fontWeight(.semibold)
        .foregroundColor(.white)
        .padding(.top, 20)
        .padding(.leading)

      LabelButtonsView(labels: tendingLabels)
      FilteredTrendingCards(selectedLabel: tendingLabels.selectedLabel, 
                            trendingVM: trendingVM)
    }
      
    .padding(.bottom)
    .background(Color.white.opacity(0.05))

    .cornerRadius(5)

  }
    
}

struct ThumbView: View {
    let image: UIImage?
    let height: CGFloat
    var width: CGFloat?
           

    var body: some View {
        let frameWidth = width ?? height
        
        VStack {
            Group {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Rectangle()
                        .foregroundColor(.gray)
                }
            }
            .frame(width: frameWidth, height: height)
        }
    }
}



struct TrendingCards: View {
    let item: TrendingItem
    let trendingVM: TrendingVM
    
    var body: some View {
        VStack{
            ThumbView(image: trendingVM.images[item.imageUrl], height: 250)
                .cornerRadius(5)
                .shadow(color: .white.opacity(0.1), radius: 5, x: 0, y: 5)
            
            VStack(alignment: .leading) {
                HStack {
                    Text(item.name)
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.leading)
                    Spacer()
                }
                Text("$" + (item.price))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading)
            }
            .padding(.top, 5)
        }
    }
}



struct FilteredTrendingCards: View {
  let selectedLabel: String
  let trendingVM: TrendingVM

  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: 20) {
        ForEach(
          trendingVM.items.filter { $0.label == selectedLabel || selectedLabel == "All" }
        ) { item in
          TrendingCards(item: item, trendingVM: (trendingVM))
        }
      }
      .padding(.horizontal)
    }
  }
}


#Preview {
  TrendingView()
}

