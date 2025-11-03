//
//  IntelligenceLogView.swift
//  MacroMate
//
//  Created by Petar Iliev on 20.10.25.
//

import SwiftUI

struct IntelligenceLogView: View {
    @Bindable var viewModel: ViewModel
    
    init(llmService: LLMServiceProviding, dataService: DataServiceProviding, onSave: @escaping (Food) -> Void) {
        self.viewModel = ViewModel(onSave: onSave, llmService: llmService, dataService: dataService)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Describe your meal...", text: $viewModel.description, axis: .vertical)
                    .lineLimit(3)
                    .submitLabel(.send)
                
                if viewModel.hasResult {
                    Section("Result") {
                        // Name text field
                        LabeledContent("Name") {
                            TextField("", text: $viewModel.nameLabel)
                                .multilineTextAlignment(.trailing)
                        }

                        // Macro nutrient text fields
                        MacroTextField(text: $viewModel.calorieLabel, titleLabel: "Calories", unitLabel: "kcal")
                        MacroTextField(text: $viewModel.proteinLabel, titleLabel: "Protein", unitLabel: "g")
                        MacroTextField(text: $viewModel.carbsLabel, titleLabel: "Carbs", unitLabel: "g")
                        MacroTextField(text: $viewModel.fatLabel, titleLabel: "Fat", unitLabel: "g")
                    }
                }
                // TODO: Save button
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.sendButtonPressed()
                    } label: {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Image(systemName: viewModel.imageName)
                        }
                    }
                    .disabled(viewModel.isSendButtonDisabled)
                }
            }
        }
    }
}

#Preview {
    IntelligenceLogView(llmService: MockLLMService(), dataService: MockDataService()) { _ in
        
    }
}
