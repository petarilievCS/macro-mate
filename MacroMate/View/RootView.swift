import SwiftUI
import SwiftData

struct RootView: View {
    private let dataService: DataServiceProviding
    private let llmService: LLMServiceProviding
    
    init(dataService: DataServiceProviding, llmService: LLMServiceProviding) {
        self.dataService = dataService
        self.llmService = llmService
    }
    
    var body: some View {
        TabView {
            // Dashboard
            Tab("Dashboard", systemImage: "house.fill") {
                NavigationStack {
                    DashboardView(dataService: dataService)
                }
            }
            
            // Daily food log
            Tab("Food", systemImage: "list.bullet.rectangle.portrait.fill") {
                NavigationStack {
                    FoodView(dataService: dataService, llmService: llmService)
                }
            }
            
            // Chat
            Tab("Chat", systemImage: "apple.intelligence") {
                NavigationStack {
                    ChatView()
                }
            }
            
            // TODO: Search
        }
    }
}

#Preview {
    RootView(dataService: MockDataService(), llmService: MockLLMService())
}
