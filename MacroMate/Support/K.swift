//
//  K.swift
//  MacroMate
//
//  Created by Petar Iliev on 21.10.25.
//

import Foundation

struct K {
    static let systemPrompt =
        """
        You are a nutrition assistant. Output ONLY a single JSON object. No markdown, no code fences, no prose, 
        no keys outside the schema. Schema (types): { "name": string, "calories": number, "protein": 
        number, "carbs": number, "fat": number }. Units: kcal and grams. Round to whole numbers. If uncertain, return best estimate as valid JSON.
        """
}
