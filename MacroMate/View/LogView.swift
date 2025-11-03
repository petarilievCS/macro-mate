//
//  LogView.swift
//  MacroMate
//
//  Created by Petar Iliev on 2.10.25.
//

import SwiftUI
import SwiftData

struct LogView: View {
    @Bindable private var viewModel: ViewModel
    
    init(onSave: @escaping (_: Food) -> Void) {
        self.viewModel = ViewModel(onSave: onSave)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $viewModel.name)
                    .lineLimit(3)
                
                TextField("Calories", text: $viewModel.calorieString)
                    .keyboardType(.decimalPad)
                
                TextField("Protein", text: $viewModel.proteinString)
                    .keyboardType(.decimalPad)
                
                TextField("Carbs", text: $viewModel.carbsString)
                    .keyboardType(.decimalPad)
                
                TextField("Fat", text: $viewModel.fatString)
                    .keyboardType(.decimalPad)
                
                DatePicker("Time", selection: $viewModel.timestamp)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.saveButtonPressed()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .disabled(viewModel.isButtonDisabled)
                }
            }
        }
    }
}

#Preview {
    LogView { _ in
        print("Save pressed")
    }
}
