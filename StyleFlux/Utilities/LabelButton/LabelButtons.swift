//
//  LabelButtonView.swift
//  StyleFlux
//
//  Created by Deepinder on 2024-09-02.
//

import SwiftUI

struct LabelButton: View {
    let label: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button{
            action()
        } label: {
            Text(label)
                .font(.subheadline)
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .background(isSelected ? Color.lightGreen : Color.white)
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(4)
//                .overlay(RoundedRectangle(cornerRadius: 4)
//                        .stroke(Color.lightGreen.opacity(0.5), lineWidth: 2))
        }
    }
}

struct LabelButtonsView: View {
    var labels: Label

    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(labels.labels, id: \.self) { label in
                    LabelButton(
                        label: label,
                        isSelected: labels.selectedLabel == label,
                        action: {labels.selectedLabel(label)}
                    )
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
    }
}


#Preview {
    LabelButtonsView(labels: Label(labels: ["All", "Shirts", "Pants", "Shorts", "Hoodies"]))
}
