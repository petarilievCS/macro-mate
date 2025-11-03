//
//  ChatView.swift
//  MacroMate
//
//  Created by Petar Iliev on 20.10.25.
//

import SwiftUI

struct ChatView: View {
    @Bindable private var viewModel: ViewModel
    
    init(llmService: LLMServiceProviding, messages: [ChatMessage] = []) {
        self.viewModel = ViewModel(llmService: llmService, messages: messages)
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            ForEach(viewModel.messages) { message in
                Text(message.text)
            }
            
            HStack {
                TextField("Text field", text: $viewModel.currentText)
                Button {
                    viewModel.sendButtonPressed()
                } label: {
                    Image(systemName: "paperplane")
                }
            }
           
        }
        .padding()
        .navigationTitle("Chat")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    viewModel.resetButtonPressed()
                } label: {
                    Image(systemName: "arrow.clockwise")
                }

            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.saveButtonPressed()
                } label: {
                    Image(systemName: "checkmark")
                }

            }
        }
    }
}

extension ChatView {
    static let mockMessages: [ChatMessage] = [
        ChatMessage(role: .agent, text: "Hi! What did you have for lunch today?"),
        ChatMessage(role: .user, text: "I had a chicken burrito with rice and beans."),
        ChatMessage(role: .agent, text: "Got it! That’s about 650 kcal, 40g protein, 60g carbs, and 20g fat."),
        ChatMessage(role: .user, text: "Can you make the protein 45g instead?"),
        ChatMessage(role: .agent, text: "Sure! Adjusted to 45g protein. Everything else stays the same."),
        ChatMessage(role: .user, text: "Perfect, log it for me.")
    ]
}

#Preview {
    ChatView(llmService: MockLLMService(), messages: ChatView.mockMessages)
}
