import SwiftUI

struct DashboardView: View {
    @Bindable private var viewModel: ViewModel
    
    init(dataService: DataServiceProviding) {
        self.viewModel = ViewModel(dataService: dataService)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 15) {
                ProgressTileView(
                    title: "Calories",
                    quantity: viewModel.totalCaloriesText,
                    unit: "kcal",
                    progress: viewModel.calorieProgress,
                    tintColor: .blue,
                    iconName: "flame.fill"
                )
                
                ProgressTileView(
                    title: "Protein",
                    quantity: viewModel.totalProteinText,
                    unit: "g",
                    progress: viewModel.proteinProgress,
                    tintColor: .green,
                    iconName: "leaf.fill"
                )

                ProgressTileView(
                    title: "Carbs",
                    quantity: viewModel.totalCarbsText,
                    unit: "g",
                    progress: viewModel.carbProgress,
                    tintColor: .yellow,
                    iconName: "bolt.fill"
                )
                
                ProgressTileView(
                    title: "Fat",
                    quantity: viewModel.totalFatText,
                    unit: "g",
                    progress: viewModel.fatProgress,
                    tintColor: .red,
                    iconName: "leaf.fill"
                )
            }
            .padding()
        }
        .navigationTitle("Dashboard")
        .toolbar {
            Button {
                viewModel.addButtonPressed()
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $viewModel.showSheet) {
            LogView(onSave: viewModel.onSave)
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

private struct DashboardSectionTitlePadding: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.leading, 10)
            .padding(.top, 10)
    }
}

private extension View {
    func dashboardSectionTitlePadding() -> some View {
        self.modifier(DashboardSectionTitlePadding())
    }
}

#Preview {
    let mockFoods: [Food] = [
        Food(name: "Chicken Breast", calories: 330, protein: 62, carbs: 0, fat: 7, timestamp: .now),
        Food(name: "White Rice", calories: 210, protein: 4, carbs: 45, fat: 0.5, timestamp: .now),
        Food(name: "Avocado", calories: 240, protein: 3, carbs: 12, fat: 22, timestamp: .now),
        Food(name: "Greek Yogurt", calories: 150, protein: 15, carbs: 8, fat: 4, timestamp: .now),
        Food(name: "Banana", calories: 105, protein: 1.3, carbs: 27, fat: 0.3, timestamp: .now)
    ]
    let mockService = MockDataService(initialFoods: mockFoods)
    return NavigationStack { DashboardView(dataService: mockService) }
}
