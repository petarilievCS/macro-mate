//
//  LLMService.swift
//  MacroMate
//
//  Created by Petar Iliev on 20.10.25.
//

import Foundation

protocol LLMServiceProviding {
    func estimateNutrition(for messages: [ChatMessage]) async throws -> FoodDTO
}

struct LLMService: LLMServiceProviding {
    private let endpoint = "https://api.openai.com/v1/responses"

    let model: String = "gpt-4.1-mini"
    
    func estimateNutrition(for messages: [ChatMessage]) async throws -> FoodDTO {
        let request = try generateRequest(with: messages)
        var (data, response) = try await URLSession.shared.data(for: request)
        
        guard let http1 = response as? HTTPURLResponse else {
            throw LLMServiceError.invalidResponse
        }
        
        // Simple single retry for 5xx
        if (500...599).contains(http1.statusCode) {
            (data, response) = try await URLSession.shared.data(for: request)
        }
        
        guard let http2 = response as? HTTPURLResponse else {
            throw LLMServiceError.invalidResponse
        }
        guard (200...299).contains(http2.statusCode) else {
            throw LLMServiceError.badStatusCode(http2.statusCode)
        }
        
        let food = try decode(data)
        return food
    }

    // Helpers
    private func generateRequest(with messages: [ChatMessage]) throws -> URLRequest {
        let url = URL(string: endpoint)!
        var request = URLRequest(url: url)
        
        var input: [LLMMessage] = []
        input.append(LLMMessage(role: "system", content: K.singleEstimationSystemPrompt))
        for message in messages {
            input.append(LLMMessage(role: message.role == .user ? "user" : "assistant", content: message.text))
        }
        
        let payload = Payload(model: model, input: input, temperature: 0.2)
        let body = try JSONEncoder().encode(payload)
        let key = try getKey()
        
        // Setup request
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        request.timeoutInterval = 15
        request.httpBody = body
        
        return request
    }
    
    private func getKey() throws -> String {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
            throw LLMServiceError.missingSecretsFile
        }
        let dictionary = NSDictionary(contentsOfFile: path)!
        guard let key = dictionary["OPENAI_API_KEY"] as? String else {
            throw LLMServiceError.invalidAPIKey
        }
        return key
    }
    
    private func decode(_ data: Data) throws -> FoodDTO {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(LLMResponse.self, from: data)
            let output = response.output.first { $0.type == "message" }
            guard let contentText = output?.content?.first?.text else {
                throw LLMServiceError.invalidResponse
            }
            // If content is fenced markdown, you can strip fences here if needed.
            guard let contentData = contentText.data(using: .utf8) else {
                throw LLMServiceError.invalidResponse
            }
            let foodDTO = try decoder.decode(FoodDTO.self, from: contentData)
            return foodDTO
        } catch {
            throw LLMServiceError.decodingFailed(underlying: error)
        }
    }
}

// Simple mock implementation for previews/tests
struct MockLLMService: LLMServiceProviding {
    func estimateNutrition(for messages: [ChatMessage]) async throws -> FoodDTO {
        try await Task.sleep(nanoseconds: 300_000_000) // 0.3s delay
        let name = messages.first?.text ?? ""
        return FoodDTO(
            name: name,
            calories: 500,
            protein: 30,
            carbs: 50,
            fat: 20
        )
    }
}

enum LLMServiceError: LocalizedError {
    case badStatusCode(Int)
    case missingSecretsFile
    case invalidAPIKey
    case invalidResponse
    case decodingFailed(underlying: Error)
    
    var errorDescription: String? {
        switch self {
        case .badStatusCode(let code):
            return "Server returned status \(code)."
        case .missingSecretsFile:
            return "Secrets.plist not found in the app bundle."
        case .invalidAPIKey:
            return "OPENAI_API_KEY is missing or invalid."
        case .invalidResponse:
            return "Unexpected or malformed response from the server."
        case .decodingFailed(let underlying):
            return "Failed to decode response: \(underlying.localizedDescription)"
        }
    }
}
