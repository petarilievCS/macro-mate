//
//  DataService.swift
//  MacroMate
//
//  Created by Petar Iliev on 30.9.25.
//

import SwiftData
import SwiftUI

protocol DataServiceProviding {
    func save(_ food: Food) throws
    func fetchFoods() throws -> [Food]
    func delete(_ food: Food)
}

struct DataService: DataServiceProviding {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func fetchFoods() throws -> [Food] {
        // Filter for foods today
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: .now)
        let end = calendar.date(byAdding: .day, value: 1, to: start)!
        let predicate = #Predicate<Food> { food in
            food.timestamp >= start && food.timestamp <= end
        }
        
        // Sorting
        let sort = [SortDescriptor(\Food.timestamp, order: .reverse)]
        
        // Perform query
        let descriptor = FetchDescriptor<Food>(predicate: predicate, sortBy: sort)
        return try context.fetch(descriptor)
    }
    
    func save(_ food: Food) throws {
        context.insert(food)
    }
    
    func delete(_ food: Food) {
        context.delete(food)
    }
}

final class MockDataService: DataServiceProviding {
    private var storage: [Food]
    
    init(initialFoods: [Food] = []) {
        self.storage = initialFoods
    }
    
    func fetchFoods() throws -> [Food] {
        storage
    }
    
    func save(_ food: Food) throws {
        storage.append(food)
    }
    
    func delete(_ food: Food) {
        storage.removeAll { foodItem in
            foodItem == food
        }
    }
}
