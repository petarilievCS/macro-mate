//
//  ChatMessage.swift
//  MacroMate
//
//  Created by Petar Iliev on 2.11.25.
//

import Foundation

enum Role {
    case user
    case agent
}

struct ChatMessage: Identifiable {
    let id = UUID()
    let role: Role
    let text: String
}
