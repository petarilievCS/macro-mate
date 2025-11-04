//
//  LLMPayload.swift
//  MacroMate
//
//  Created by Petar Iliev on 20.10.25.
//

struct Payload: Encodable {
    let model: String
    let input: [LLMMessage]
    let temperature: Double
}

struct LLMMessage: Encodable {
    let role: String
    let content: String
}
