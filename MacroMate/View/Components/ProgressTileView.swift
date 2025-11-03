//
//  ProgressTileView.swift
//  MacroMate
//
//  Created by Petar Iliev on 1.10.25.
//

import SwiftUI

struct ProgressTileView: View {
    // State
    let title: String
    let quantity: String
    let unit: String
    let progress: Double // 0.0 to 1.0
    let tintColor: Color
    let iconName: String
    
    // UI
    let cornerRadius = 20
    var cornerSize: CGSize {
        CGSize(width: cornerRadius, height: cornerRadius)
    }
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                // Title
                HStack {
                    Image(systemName: iconName)
                        .foregroundStyle(tintColor)
                    
                    Text(title)
                        .font(.title3)
                        .fontWeight(.bold)
                }

                Spacer()
                
                // Subtitle
                HStack(alignment: .firstTextBaseline) {
                    Text(quantity)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                    Text(unit)
                        .foregroundStyle(.secondary)
                        .fontWeight(.bold)
                }

            }
            .padding(.vertical, 15)
            .padding(.leading, 20)
            
            Spacer()
            
            RingProgressView(progress: progress, ringColor: tintColor)
                .padding(20)
        }
        .background(.tertiary)
        .clipShape(RoundedRectangle(cornerSize: cornerSize))
        .frame(maxHeight: 200)
    }
}

#Preview {
    Group {
        ProgressTileView(title: "Calories", quantity: "1000", unit: "kcal", progress: 0.5, tintColor: .blue, iconName: "flame.fill")
        ProgressTileView(title: "Protein", quantity: "60", unit: "g", progress: 0.8, tintColor: .green, iconName: "leaf.fill")
        ProgressTileView(title: "Carbs", quantity: "200", unit: "g", progress: 1.0, tintColor: .orange, iconName: "bolt.fill")
    }
}
