//
//  FoodCell.swift
//  MacroMate
//
//  Created by Petar Iliev on 15.10.25.
//

import SwiftUI

struct FoodCell: View {
    let food: Food
    
    private var calorieString: String {
        return "\(String(Int(food.calories))) kcal"
    }
    
    var body: some View {
        HStack {
            Text(food.name)
                .bold()
            Spacer()
            Text(String(calorieString))
        }
        
    }
}
