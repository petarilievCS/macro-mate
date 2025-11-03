//
//  RingProgressView.swift
//  MacroMate
//
//  Created by Petar Iliev on 1.10.25.
//

import SwiftUI

struct RingProgressView: View {
    var progress: Double
    var thickness: CGFloat = 35
    var backgroundColor: Color = .gray.opacity(0.3)
    var ringColor: Color = .blue

    var body: some View {
        ZStack {
            // Background circle (track)
            Circle()
                .stroke(backgroundColor, lineWidth: thickness)

            // Foreground arc (progress)
            Circle()
                .trim(from: 0, to: min(progress, 1.0))
                .stroke(ringColor, style: StrokeStyle(lineWidth: thickness, lineCap: .round))
                .rotationEffect(.degrees(-90)) // Start from top
                .animation(.easeInOut, value: progress)
        }
        .padding(thickness / 2)
    }
}

#Preview {
    VStack(spacing: 24) {
        RingProgressView(progress: 0.75)
            .frame(width: 120, height: 120)
    }
    .padding()
}
