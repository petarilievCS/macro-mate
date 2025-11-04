//
//  MessageBubble.swift
//  MacroMate
//
//  Created by Petar Iliev on 3.11.25.
//

import SwiftUI

struct MessageBubble: View {
    let message: ChatMessage
    
    private var color: Color {
        return message.role == .user ? .blue : .gray
    }
    
    var body: some View {
        HStack {
            if message.role == .user {
                Spacer()
            }
            Text(message.text)
                .padding()
                .background(
                    Capsule()
                        .fill(color)
                )
                .foregroundStyle(.white)
            if message.role == .agent {
                Spacer()
            }
        }
    }
}

#Preview {
    MessageBubble(message: ChatMessage(role: .agent, text: "Hi! What did you have for lunch today?"))
    MessageBubble(message: ChatMessage(role: .user, text: "I had a chicken burrito with rice and beans."))
}
