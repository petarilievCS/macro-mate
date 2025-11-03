//
//  ChatViewModel.swift
//  MacroMate
//
//  Created by Petar Iliev on 2.11.25.
//

import SwiftUI

extension ChatView {
    @Observable
    class ViewModel {
        private let llmService: LLMServiceProviding
        
        var currentText: String = ""
        var messages: [ChatMessage]
        var isSending = false
        var error: String?
        
        init(llmService: LLMServiceProviding, messages: [ChatMessage]) {
            self.llmService = llmService
            self.messages = messages
        }
        
        func sendButtonPressed() {
            
        }
        
        func saveButtonPressed() {
            
        }
        
        func resetButtonPressed() {
            
        }
    }
}
