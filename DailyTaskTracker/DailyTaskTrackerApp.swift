import SwiftUI

@main
struct DailyTaskTrackerApp: App {
    @StateObject private var taskStore = TaskStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taskStore)
        }
    }
}