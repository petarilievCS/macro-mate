//
//  Response.swift
//  MacroMate
//
//  Created by Petar Iliev on 20.10.25.
//

struct LLMResponse: Decodable {
    let output: [LLMOutput]
}

struct LLMOutput: Decodable {
    let type: String
    let content: [LLMContent]?
}

struct LLMContent: Decodable {
    let text: String
}

struct FoodDTO: Decodable {
    let name: String
    let calories: Double
    let protein: Double
    let carbs: Double
    let fat: Double
}
