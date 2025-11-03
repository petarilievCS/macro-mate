//
//  DashboardViewModel.swift
//  MacroMate
//
//  Created by Petar Iliev on 9.10.25.
//

import SwiftUI

extension DashboardView {
    @Observable
    class ViewModel {
        private var foods: [Food] = []
        
        private let dataService: DataServiceProviding
        
        init(
            dataService: DataServiceProviding,
            foods: [Food] = [],
            calorieGoal: Double = 1900,
            proteinGoal: Double = 145,
            carbGoal: Double = 185,
            fatGoal: Double = 65
        ) {
            self.dataService = dataService
            self.foods = foods
            self.calorieGoal = calorieGoal
            self.proteinGoal = proteinGoal
            self.carbGoal = carbGoal
            self.fatGoal = fatGoal
        }
        
        private var totalCalories: Double {
            return foods.reduce(0) { $0 + $1.calories }
        }
        
        private var totalProtein: Double {
            return foods.reduce(0) { $0 + $1.protein }
        }
        
        private var totalCarbs: Double {
            return foods.reduce(0) { $0 + $1.carbs }
        }
        
        private var totalFat: Double {
            return foods.reduce(0) { $0 + $1.fat }
        }
        
        private var calorieGoal: Double = 1900
        private var proteinGoal: Double = 145
        private var carbGoal: Double = 185
        private var fatGoal: Double = 65
        
        var totalCaloriesText: String {
            return String(format: "%.0f", totalCalories)
        }
        
        var totalProteinText: String {
            return String(format: "%.0f", totalProtein)
        }
        
        var totalCarbsText: String {
            return String(format: "%.0f", totalCarbs)
        }
        
        var totalFatText: String {
            return String(format: "%.0f", totalFat)
        }
        
        var calorieProgress: Double {
            return (totalCalories / calorieGoal)
        }
        
        var proteinProgress: Double {
            return (totalProtein / proteinGoal)
        }
        
        var carbProgress: Double {
            return (totalCarbs / carbGoal)
        }
        
        var fatProgress: Double {
            return (totalFat / fatGoal)
        }
        
        var showSheet: Bool = false
        
        var onSave: (Food) -> Void {
            { [weak self] food in self?.saveFood(food: food) }
        }
        
        func addButtonPressed() { showSheet = true }
        
        func onAppear() {
            do {
                foods = try dataService.fetchFoods()
            } catch {
                print("Error: \(error)")
            }
        }
        
        private func saveFood(food: Food) {
            foods.append(food)
            
            do {
                try dataService.save(food)
            } catch {
                print("Error: \(error)")
            }
            
            showSheet = false
        }
    }
}
