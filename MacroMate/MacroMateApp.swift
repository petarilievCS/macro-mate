//
//  MacroMateApp.swift
//  MacroMate
//
//  Created by Petar Iliev on 30.9.25.
//

import SwiftUI
import SwiftData

@main
struct MacroMateApp: App {
    private let dataService: DataServiceProviding
    private let llmService: LLMServiceProviding
    
    init() {
        let container = try! ModelContainer(for: Food.self)
        let context = ModelContext(container)
        self.dataService = DataService(context: context)
        self.llmService = LLMService()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView(dataService: dataService, llmService: llmService)
        } 
    }
}
