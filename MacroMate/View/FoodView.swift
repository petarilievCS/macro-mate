//
//  FoodView.swift
//  MacroMate
//
//  Created by Petar Iliev on 15.10.25.
//

import SwiftUI

struct FoodView: View {
    @Bindable private var viewModel: ViewModel
    
    init(dataService: DataServiceProviding, llmService: LLMServiceProviding) {
        self.viewModel = ViewModel(dataService: dataService, llmService: llmService)
    }
    
    var body: some View {
        List {
            ForEach(viewModel.foods) { food in
                FoodCell(food: food)
            }
            .onDelete { indexSet in
                viewModel.onDelete(indexSet: indexSet)
            }
            .onTapGesture {
                // TODO: Implement EditView()
                print("Tapped")
            }
        }
        .navigationTitle("Food")
        .toolbar {
            Menu {
                Button("Manual Log") {
                    viewModel.manualLogButtonPressed()
                }
                Button("Describe Meal (AI)") {
                    viewModel.describeMealButtonPressed()
                }
            } label: {
                Image(systemName: "plus")
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .sheet(isPresented: $viewModel.showLogView) {
            LogView(onSave: viewModel.onSave)
        }
        .sheet(isPresented: $viewModel.showIntelligenceLogView) {
            IntelligenceLogView(llmService: viewModel.llmService, dataService: viewModel.dataService, onSave: viewModel.onSave)
        }
    }
}

#Preview {
    let mockFoods: [Food] = [
        Food(name: "Chicken Breast", calories: 330, protein: 62, carbs: 0, fat: 7, timestamp: .now),
        Food(name: "White Rice", calories: 210, protein: 4, carbs: 45, fat: 1, timestamp: .now),
        Food(name: "Avocado", calories: 240, protein: 3, carbs: 12, fat: 22, timestamp: .now)
    ]
    let mockDataService = MockDataService(initialFoods: mockFoods)
    let mockLLMService = MockLLMService()
    return FoodView(dataService: mockDataService, llmService: mockLLMService)
}
